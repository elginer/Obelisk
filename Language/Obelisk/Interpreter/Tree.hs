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
   -XMultiParamTypeClasses
#-}

-- | Common tools for interpreters which interpret some form of Abstract Syntax tree.
module Language.Obelisk.Interpreter where

import qualified Data.Map as M
import Data.Map (Map)

-- | The variables in scope.  Parametrized over a function type.
newtype Scope f = Scope {unscope :: Map String (Value f)}

-- | Values.  Parametrized over a function type.
data Value f =
     -- | Functions
     Function f
   | -- | Characters
     Ch Char
   | -- | Integers
     Int Int

-- | AST elements can be evaluated.  This corrosponds to ONE evaluation step.  The ast is parametrized over a function data type.
class Eval f f => Eval ast f where
   eval :: ast -> Scope f -> Value f
