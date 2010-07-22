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
    -XExistentialQuantification
    -XTypeSynonymInstances
#-}
-- | Nice looking compiler errors.
module Language.Obelisk.Error
   (module Language.Obelisk.Pretty
   ,CompilerError
   ,ErrorReport (..)
   ,new_error
   ,empty_error
   ,error_line
   ,error_lines
   ,error_section
   ,error_join
   ,broken_compiler)
   where

import Language.Obelisk.Pretty

import Data.List

-- | A nice looking compiler error
data CompilerError =
     -- | Error text
     forall p . Pretty p => PrettyError p
   | ErrorMessage [CompilerError]
   | NoRaise [CompilerError]

instance Pretty CompilerError where
   pretty' ce i =
      case ce of
         PrettyError p -> pretty' p i
         ErrorMessage ces ->
            foldr (.) id $ (map (flip pretty' (i + 1))) ces
         NoRaise ces ->
            foldr (.) id $ (map (flip pretty' i)) ces

-- | A class for things which can be turned into compiler error reports
class ErrorReport err where
   report :: err -> CompilerError

-- Strings can be turned to errors
instance ErrorReport String where
   report = new_error 

-- | Combine multiple errors into one report
error_join :: [CompilerError] -> CompilerError
error_join = NoRaise . intersperse (new_error $ "\n" ++ replicate 50 '-' ++ "\n" )

-- | An empty error
empty_error :: CompilerError
empty_error = ErrorMessage []

-- | Create a new error
new_error :: Pretty p => p -> CompilerError
new_error p = PrettyError p

-- | Add a number of lines to the start of the error
error_lines :: Pretty p => [p] -> CompilerError -> CompilerError
error_lines ps ce = 
   foldr error_line ce ps

-- | Add a line to the start of the error (This appears further up the error report)
error_line :: Pretty p => p -> CompilerError -> CompilerError
error_line p ce =
   case ce of
      PrettyError _ -> NoRaise [PrettyError p, ce]
      ErrorMessage ers -> ErrorMessage $ PrettyError p : ers
      NoRaise ers -> NoRaise $ PrettyError p : ers

-- | Create a new error section (This appears further up, and with fewer tabs than the rest of the report)
error_section :: CompilerError -> CompilerError
error_section ce =
   ErrorMessage [ErrorMessage [ce]]

-- | There was an error because the compiler was broken
broken_compiler :: [String] -> CompilerError -> a
broken_compiler msg =
   error . pretty . error_lines ["PROGRAMMING LANGUAGE FAIL"
                                ,"The compiler broke.  Something most wrong has certainly happened."
                                ,"Report the following as a bug to John Morrice at spoon@killersmurf.com."] . error_section . error_lines msg
