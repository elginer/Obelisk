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

import Data.Either

import Control.Arrow

instance Typed ScopedFDef where
   -- The type of the function is the functions type, but try to see if there are errors in unification in the where clauses
   typeof (Def (_,cf) typ@(QType _ _ unqtyp) _ fargs bl@(Block _ exps) wh) tev =
      if length tylist - 1 /= length fargs
         then Left (Just typ, [WrongNumberOfFormalArguments (length tylist - 1) (length fargs) cf])
         else
            let eown = unify (return_type typ) bl new_tev
            in  if null where_errors
                   then eown
                   else Left $ 
                      either (second (where_errors ++))
                             (\met -> (Just met, where_errors))
                             eown
      where
      where_errors = 
         concatMap snd $ lefts $ map (flip typeof new_tev) wh
      tylist =
         case unqtyp of
            Type _ -> broken_function_type typ
            Function ts -> ts  
      frag =
         if null exps
            then cf
            else fragment $ last exps
      new_tev = with_where with_fargs
      with_where fatev = fatev {types = foldr (uncurry M.insert) (types fatev) $ map (\w -> (name w, official_type w)) wh}
      with_fargs = tev {types = foldr (uncurry M.insert) (types tev) $ zip fargs $ map (new_type . sname) tylist}

instance Typed ScopedDef where
   -- The type of the define clause is either the type of the function, or an attempt at unifying the type of the Constant with the type of its Expression
   typeof d env =
      case d of
         FDef f -> typeof f env
         Constant (_, cf) t _ e ->
            unify t e env
