{-# OPTIONS
    -XExistentialQuantification
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
   ,broken_compiler)
   where

import Language.Obelisk.Pretty

-- | A nice looking compiler error
data CompilerError =
     -- | Error text
     forall p . Pretty p => PrettyError p
   | ErrorMessage [CompilerError]

instance Pretty CompilerError where
   pretty' ce i =
      case ce of
         PrettyError p -> pretty' p i
         ErrorMessage ces ->
            foldr (.) id $ (map (flip pretty' (i + 1))) ces

-- | A class for things which can be turned into compiler error reports
class ErrorReport err where
   report :: err -> CompilerError

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
      PrettyError _ -> ErrorMessage [PrettyError p, ce]
      ErrorMessage ers -> ErrorMessage $ PrettyError p : ers

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
