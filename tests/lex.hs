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

-- Ensure that Obelisk source is lexed properly!
import Language.Obelisk.Lexer
import Language.Obelisk.Lexer.Token

-- Examine the output.  Make sure it is 'okay'.  
main =
   mapM lex_test tests

lex_test = 
   either print print . ob_lex "test data"

tests =
   ["(def nice 'c'"
   ,"))) 'a' where"
   ,"123"
   ,"1 2 3 Because"
   ,"//howdy\n(def (c) (x c))"
   ,"/* all is well */ + 1"
   ,"let let let let 222"]
