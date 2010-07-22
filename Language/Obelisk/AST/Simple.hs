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

{-# OPTIONS
    -XTypeSynonymInstances
#-}
-- | A Simple AST, as parsed from source code
module Language.Obelisk.AST.Simple 
   (module Language.Obelisk.AST
   ,module Language.Obelisk.AST.CodeFragment
   ,SimpleObelisk
   ,SimpleDef
   ,SimpleFDef
   ,SimpleExp
   ,SimpleBlock)
   where

import Language.Obelisk.AST
import Language.Obelisk.AST.CodeFragment

instance Fragment SimpleFDef where
   fragment (Def f _ _ _ _ _) = f 

-- | The obelisk AST, where variables are strings, and the metadata is a code fragment near the AST component 
type SimpleObelisk = Obelisk String CodeFragment 

type SimpleFDef = FDef String CodeFragment

type SimpleDef = Def String CodeFragment

type SimpleExp = Exp String CodeFragment

type SimpleBlock = Block String CodeFragment
