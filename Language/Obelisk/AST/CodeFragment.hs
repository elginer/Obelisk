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

-- | Code fragments for nice error reporting
module Language.Obelisk.AST.CodeFragment where

import Error.Report

import Text.Parsec.Pos

-- | A code fragment displayed in error reporting makes debugging easier for users
data CodeFragment = CodeFragment
   {pos :: SourcePos
   ,code :: String
   }
   deriving Show

instance ErrorReport CodeFragment where
   report c = 
      error_lines ["In " ++ show (pos c), "Near code:"] $ 
        error_section $ error_lines (lines $ code c) empty_error

-- | Get a code fragment from the ast
class Fragment ast where
   fragment :: ast -> CodeFragment

-- | A compiler injected code fragment
inject_fragment :: CodeFragment
inject_fragment = CodeFragment (newPos "__Compiler Injected__" 0 0) ""
