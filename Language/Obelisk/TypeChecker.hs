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
