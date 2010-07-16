-- | Type checker for Obelisk
module Language.Obelisk.TypeChecker where

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.Typed
import Language.Obelisk.TypeChecker.Def

import Data.Either

-- | Ensure type unification succeeds
echeck :: ScopedObelisk -> TypeEnvironment -> Either [TypeError] ScopedObelisk
echeck ob@(Obelisk defs) env =
   if length (rights ets) == length defs
      then Right ob
      else Left $ concatMap snd $ lefts ets
   where
   ets = map (flip typeof env) defs
