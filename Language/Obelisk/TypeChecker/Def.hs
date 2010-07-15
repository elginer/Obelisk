-- | Type check definitions
module Language.Obelisk.TypeChecker.Def where

import Language.Obelisk.TypeChecker.Typed
import Language.Obelisk.TypeChecker.Block

import qualified Data.Map as M

instance Typed ScopedFDef where
   -- The type of the function is the functions type, but try to see if there are errors in unification in the where clauses
   typeof (Def (_,cf) t fargs _ bl@(Block exps) wh) tev =
      if length tylist - 1 /= length fargs
         then (Just t, Left [WrongNumberOfFormalArguments (length tylist - 1) (length fargs) cf])
         else unify (return_type t) bl frag
      where
      frag =
         if null exps
            then cf
            else fragment $ last exps
      new_tev = with_where $ with_fargs tev
      with_where tev = tev {types = foldr (uncurry M.insert) (types tev) $ map (\w -> (name w, typeof w)) wh}
      with_fargs = tev {types = foldr (uncurry M.insert) (types tev) $ zip fargs tylist}

instance Typed ScopedDef where
   -- The type of the define clause is either the type of the function, or an attempt at unifying the type of the Constant with the type of its Expression
   typeof d env =
      case d of
         FDef f -> typeof f
         Constant (_, cf) t _ e ->
            unify t e cf
