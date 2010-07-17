{-#
   OPTIONS
   -XTypeSynonymInstances
#-}

-- | Type check definitions
module Language.Obelisk.TypeChecker.Def where

import Language.Obelisk.Error

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.Typed
import Language.Obelisk.TypeChecker.Expression

import qualified Data.Map as M

import Control.Arrow

instance Typed ScopedFDef where
   -- The type of the function is the functions type, but try to see if there are errors in unification in the where clauses
   typeof (Def (_,cf) typ@(QType _ _ unqtyp) fun_name fargs bl@(Block _ exps) wh) tev =
      (Just typ, errs)
      where
      errs =
         if length tylist - 1 /= length fargs
            then [WrongNumberOfFormalArguments (length tylist - 1) (length fargs) cf]
            else where_errors ++ own_errs
      own_errs = unify (return_type typ) bl new_tev
      where_errors = 
         concatMap snd $ map (flip typeof new_tev) wh
      tylist =
         case unqtyp of
            Type _ -> broken_function_type typ
            Function ts -> ts  
      frag =
         if null exps
            then cf
            else fragment $ last exps
      new_tev = whfr_tev {types = M.insert fun_name typ $ types whfr_tev}
      whfr_tev = with_where with_fargs 
      with_where fatev = fatev {types = foldr (uncurry M.insert) (types fatev) $ map (\w -> (name w, official_type w)) wh}
      with_fargs = tev {types = foldr (uncurry M.insert) (types tev) $ zip fargs $ map (new_type . sname) tylist}

instance Typed ScopedDef where
   -- The type of the define clause is either the type of the function, or an attempt at unifying the type of the Constant with the type of its Expression
   typeof d env =
      case d of
         FDef f -> typeof f env
         Constant (_, cf) t _ e ->
            (Just t, unify t e env)
