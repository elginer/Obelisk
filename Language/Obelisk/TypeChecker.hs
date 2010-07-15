-- | Type checker for Obelisk
module Language.Obelisk.TypeChecker where

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.FDef

import Data.Map (Map)
import qualified Data.Map as M

import Data.Either

import Control.Monad

import Control.Arrow

-- | Ensure type unification succeeds
echeck :: ScopedObelisk -> Either [TypeError] ScopedObelisk
echeck ob@(Obelisk defs) =
   if length (rights defs) == length defs
      then Right ob
      else Left $ map snd $ concat $ lefts ets
   where
   ets = map typeof defs
