-- | Type checker for Obelisk
module Language.Obelisk.TypeChecker where

import Language.Obelisk.Error

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.Typed
import Language.Obelisk.TypeChecker.Def

import Data.Either

import qualified Data.Map as M

-- | Type checker
check :: ScopedObelisk -> ScopedObelisk
check =
   either (error . pretty . error_join . map report) id . flip echeck joke_env 

-- | This type checking environment is a bit of a joke
joke_env :: TypeEnvironment
joke_env = TypeEnvironment $ M.fromList [("getc", new_ftype ["Char"]), ("putc", new_ftype ["Char", "Void"])]

-- | Ensure type unification succeeds
echeck :: ScopedObelisk -> TypeEnvironment -> Either [TypeError] ScopedObelisk
echeck ob@(Obelisk defs) env =
   if length (filter_correct ets) == length defs
      then Right ob
      else Left $ concatMap snd ets
   where
   ets = map (flip typeof global_env) defs
   global_env = env {types = foldr (\d -> M.insert (name d) (official_type $ FDef d)) (types env) defs}
