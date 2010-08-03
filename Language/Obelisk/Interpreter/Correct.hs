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

-- | Interpreter for type-checked AST
module Language.Obelisk.Interpreter.Correct where

import Language.Obelisk.Error

import Language.Obelisk.AST.Correct
import Languaeg.Obelisk.Interpreter.Tree

import qualified Data.Map as M
import Data.Map (Map)

import Control.Monad

-- | Interpret 'correct' Obelisk
interpret :: CorrectObelisk -> IO ()
interpret = sinterpret . uncorrect

-- | Interpret Scoped Obelisk
sinterpret :: ScopedObelisk -> IO ()
sinterpret ob =
   eval lookup_main scope 
   where
   lookup_main =
      case lookup_var "main" scope of
         Function f -> f
         _          -> error "Expected main function"
   scope = initial_environment ob

initial_environment :: ScopedObelisk -> Scope
initial_environment = add_function_definitions (Scope M.empty)

add_definitions :: Scope -> [ScopedDef] -> Scope
add_definitions scope defs = 
   (flip foldr add_definition) (filter is_constant defs) $ 
      foldr add_definition scope (filter is_function defs)

add_definition :: ScopedDef -> Scope -> Scope
add_definition d s = new_var (name d) val s
   where
   val =
      case d of
         FDef f -> Function f
         Constant _ _ _ e -> force_eval e s

is_function :: ScopedDef -> Bool
is_function d =
   case d of 
      FDef d -> True
      _      -> False

is_constant :: ScopedDef -> Bool
is_constant d = 
   case d of
      Constant _ _ _ _ -> True
      _                -> False

instance Eval ScopedBlock ScopedFDef where
   eval (Block _ es defs) sc =
      fmap msum $ forM es (flip eval new_scope)
      where
      new_scope = add_definitions sc defs

instance Eval ScopedExp ScopedFDef where
   eval exp s =
      case exp of
         If _ test on_true on_false ->
            case force_eval test of
               Bool b ->
                  if b
                     then eval on_true s
                     else eval on_false s
               _ -> interpret_error "If statement test did not return boolean:" $ fragment test
         OVar _ v -> return $ Just $ lookup_var (fragment exp) v s
         OInt i -> return $ Just $ Int i
         OBool _ b -> return $ Just $ Bool b
         OChar _ c -> return $ Just $ Ch c
         Apply _ fu args -> apply (fragment exp) fu args s

apply :: CodeFragment 
      -> ScopedExp 
      -> [ScopedExp] 
      -> Scope 
      -> IO (Maybe (Value ScopedFDef))
apply cf fu_exp args sc =
   apply_with_fun $ 
      case force_eval fu_exp sc of
         Function f -> f
         _          -> interpret_error $ "Applying arguments to simple type:" cf
   where
   apply_with_fun (FDef _ _ nm fargs block wher) =
      
      where
      new_scope = new_var nm $ foldr (uncurry new_var) sc $ zip
