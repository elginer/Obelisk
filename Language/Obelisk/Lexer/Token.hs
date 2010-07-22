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

-- | Tokens for Obelisk
module Language.Obelisk.Lexer.Token where

-- | Obelisk tokens, lexed by the lexer.  See `Language.Obelisk.Lexer`
data Token =
   -- | An integer
   TInt Integer
   | -- | A boolean true
     TTrue
   | -- | A boolean false
     TFalse
   | -- | Begin function definition
     TDef
   | -- | Parenthesis open
     TParOpen
   | -- | Parenthesis closed
     TParClose
   | -- | A variable, or left-fixity function
     TVar String
   | -- | An infix variable, an operator
     TOp String
   | -- | An if statement
     TIf
   | -- | Constant set operator
     TConstant
   | -- | 'where' clause
     TWhere
   | -- | The name of a class
     TClassName String
   | -- | A function arrow
     TArrow
   | -- | A type terminator
     TTypeTerm
   | -- | A literal character
     TChar Char
   | -- The end of file
     TEOF

instance Show Token where
   show t =
      case t of
         TInt i    -> show i
         TTrue     -> "true"
         TFalse    -> "false"
         TDef      -> "def"
         TParOpen  -> "("
         TParClose -> ")"
         TVar v    -> v
         TOp op    -> op
         TIf       -> "if"
         TConstant -> "let"
         TWhere    -> "where"
         TArrow    -> "->"
         TTypeTerm -> "#"
         TClassName c -> c
         TChar      c -> '\'' : c : '\'' : []
         TEOF      -> "end of file"
