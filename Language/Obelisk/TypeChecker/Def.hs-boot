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

{-#
   OPTIONS
   -XTypeSynonymInstances
#-}

-- | Type check definitions
module Language.Obelisk.TypeChecker.Def where

import Language.Obelisk.Error 

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.Typed

import qualified Data.Map as M

import Control.Arrow

-- | Update the type environment with the types described in a where clause
with_where :: [ScopedDef] -> TypeEnvironment -> TypeEnvironment

-- | The errors from a where clause
where_errors :: [ScopedDef] -> TypeEnvironment -> [TypeError]

instance Typed ScopedFDef where

instance Typed ScopedDef where
