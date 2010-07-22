{-

Copyright 2010 John Morrice

This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License

This file is part of The Obelisk Programming Language.

    The Obelisk Programming Language is free software: you can 
    redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or any later version.

    The Obelisk Programming Language is distributed in the hope that it 
    will be useful, but WITHOUT ANY WARRANTY; without even the implied 
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with The Obelisk Programming Language.  
    If not, see <http://www.gnu.org/licenses/>

-}

-- | Ensure all variables are within scope
module Language.Obelisk.Scoper where

import Language.Obelisk.AST.Simple
import Language.Obelisk.AST.Scoped

import Language.Obelisk.Error

import Data.List
import Data.Either

import qualified Data.Set as S

data ScopeError = 
   OutOfScope String CodeFragment
   | DuplicateName String CodeFragment

instance ErrorReport ScopeError where
   report se =
      case se of
         OutOfScope v cf ->
            error_line ("Not in scope: " ++ v) $ report cf

         DuplicateName v cf ->
            error_line ("A definition has the same name as another variable or definition in the same scope: " ++ v) $ report cf

-- | Scoping transformation
class Scoper s where
   scope' :: ClosureTable -- ^ The free variables in the current environment
          -> s String CodeFragment -- ^ The simple AST type
          -> s String (ClosureTable, CodeFragment) -- ^ The scoped AST type

-- | Check all variables are within scope
class ScopeChecker s where
   scope_check :: s String (ClosureTable, CodeFragment) -- ^ The AST element to check
               -> [ScopeError]

-- Check the function contains no scope errors, including duplicate names
instance ScopeChecker FDef where
   scope_check (Def (_, cf) _ dname fargs bl wh) = 
      dup_errs ++ scope_check bl ++ concat (map scope_check wh)
      where
      dup_errs = where_fargs_clash ++ fargs_dup ++ where_dup
      fargs_dup = find_duplicates id (const cf) fargs
      where_dup = find_duplicates name fragment wh 
      where_fargs_clash = map (uncurry DuplicateName) $ filter (\wf -> S.member (fst wf) clash) wh_frgs
      clash = S.intersection (S.fromList $ dname : fargs) (S.fromList $ map name wh)
      wh_frgs = map (\d ->
         (name d, fragment d)) wh
      

-- Check the definition contains no scope errors
instance ScopeChecker Def where
   scope_check d =
      case d of
         FDef def       -> scope_check def
         Constant _ _ _ e -> scope_check e

-- Check the expression contains no scope errors
instance ScopeChecker Exp where
   scope_check e =
      case e of
         If _ test true false -> scope_check test ++ scope_check true ++ scope_check false
         Apply _ e args    -> scope_check e ++ concat (map scope_check args)
         Infix _ a _ b    -> scope_check a ++ scope_check b
         OVar (cs, fr) v ->
            var_check v fr cs
         OInt _ _ -> []
         OBool _ _ -> []
         OChar _ _ -> []
      where
      var_check v fr (ClosureTable cs) = 
         maybe [OutOfScope v fr] (const []) $ find (\e -> def_name e == v) cs

-- Check the block contains no scope errors
instance ScopeChecker Block where
   scope_check (Block _ es) = concat $ map scope_check es

-- | Check variables are within scope, alter AST to provide information on which functions need access to which variables (forming a closure over those variables)
scope :: SimpleObelisk -> ScopedObelisk
scope = 
   either error id . escope

-- | Check variables are within scope, alter AST to provide information on which functions need access to which variables (forming a closure over those variables)
escope :: SimpleObelisk -> Either String ScopedObelisk
escope (Obelisk defs) =
   if null errs
      then Right $ Obelisk scoped
      else Left $ pretty $ error_join $ map report errs
   where
   errs = duplicate_top_level defs ++ concat (map scope_check scoped)
   scoped = map (scope' $ ClosureTable $ form_env "" $ map FDef defs) defs

-- | Check for duplicate top level functions
duplicate_top_level :: [SimpleFDef] -> [ScopeError]
duplicate_top_level = find_duplicates name fragment

-- | Find duplicate entries of a data-type
find_duplicates :: (a -> String) -> (a -> CodeFragment) -> [a] -> [ScopeError]
find_duplicates name dcf = snd .
   foldr (\d (s, es) ->
      if S.member (name d) s
         then (s, DuplicateName (name d) (dcf d) : es)
         else (S.insert (name d) s, es)) (S.empty, []) 

-- | Gather the names of definitions
form_env :: String -- ^ The function in which these definitions were made
         -> [SimpleDef] -- ^ The definitions for which we are creating this closure table 
         -> [ClosureEntry] -- ^ The inside of a closure table
form_env f =
   map (ClosureEntry f . name)

-- Transform simple to scoped function definitions
instance Scoper FDef where
   scope' env@(ClosureTable fvs) (Def cf typ name fargs bl wh) =
      Def (env, cf) typ name fargs (recurse (bl_env) bl) (map (recurse where_env) wh)
      where
      bl_env = form_env name wh
      where_env = form_env name $ filter (\d ->
         case d of
            FDef _ -> True
            _      -> False) wh
      recurse :: Scoper a => [ClosureEntry] -> a String CodeFragment -> a String (ClosureTable, CodeFragment)
      recurse where_env = scope' (ClosureTable $ fvs ++ map (ClosureEntry name) fargs ++ where_env)

-- Transform simple to scoped definitions
instance Scoper Def where
   scope' env d =
      case d of
         FDef def          -> FDef $ scope' env def
         Constant fr typ v exp -> Constant (env, fr) typ v $ scope' env exp

-- Transform simple to scoped expressions
instance Scoper Exp where
   scope' env e = 
      case e of
         If fr test true false -> If (env, fr) (scope' env test) (scope' env true) (scope' env false)
         Apply fr e args -> Apply (env, fr) (scope' env e) (map (scope' env) args)
         Infix fr a op b -> Infix (env, fr) (scope' env a) op (scope' env b)
         -- Do we really need to include the closure table for literals?
         OVar fr v -> OVar (env, fr) v
         OInt fr i -> OInt (env, fr) i
         OBool fr b -> OBool (env, fr) b
         OChar fr c -> OChar (env, fr) c

-- Transform simple to scoped blocks
instance Scoper Block where
   scope' env (Block fr es) =
      Block (env, fr) $ map (scope' env) es
