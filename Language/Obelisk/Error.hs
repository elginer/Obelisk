{-# OPTIONS
    -XExistentialQuantification
#-}
-- | Nice looking compiler errors where
module Language.Obelisk.Error
   (CompilerError
   ,new_error
   ,describe_error)
   where

import Language.Obelisk.Pretty

-- | A nice looking compiler error
data CompilerError =
     -- | Error text
     forall p . Pretty p => PrettyError p
   | ErrorMessage [CompilerError]

instance Pretty CompilerError where
   pretty ce i =
      case ce of
         PrettyError p -> pretty p i
         ErrorMessage ces -> foldr (.) id (map (flip pretty (i + 1)))

-- | Create a new error
new_error :: Pretty p => p -> CompilerError
new_error p = PrettyError p

-- | Add a description to the error (This appears further up the error report)
describe_error :: Pretty p => p -> CompilerError -> CompilerError
describe_error p ce =
   case ce of
      PrettyError _ -> ErrorMessage [PrettyError p, ce]
      ErrorMessage ers -> ErrorMessage $ PrettyError p : ers 
