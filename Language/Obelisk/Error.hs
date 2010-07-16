{-# OPTIONS
    -XExistentialQuantification
#-}
-- | Nice looking compiler errors.
module Language.Obelisk.Error where
   (module Language.Obelisk.Pretty
   ,CompilerError
   ,new_error
   ,empty_error
   ,error_line
   ,error_section)
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
         ErrorMessage ces -> foldr (.) id (map (flip pretty' (i + 1)))

-- | An empty error
empty_error :: CompilerError
empty_error = ErrorMessage []

-- | Create a new error
new_error :: Pretty p => p -> CompilerError
new_error p = PrettyError p

-- | Add a number of lines to the start of the error
error_lines :: Pretty p => [p] -> CompilerError -> CompilerError
error_lines ps ce = 
   foldr error_line ce (reverse ps)

-- | Add a line to the start of the error (This appears further up the error report)
error_line :: Pretty p => p -> CompilerError -> CompilerError
error_line p ce =
   case ce of
      PrettyError _ -> ErrorMessage [PrettyError p, ce]
      ErrorMessage ers -> ErrorMessage $ PrettyError p : ers

-- | Create a new error section (This appears further up, and with fewer tabs than the rest of the report)
error_section :: Pretty p => CompilerError -> CompilerError
error_section p ce =
   ErrorMessage [ErrorMessge [ce]]
