{-#
   OPTIONS
   -XTypeSynonymInstances
#-}
-- | Pretty printing!
module Language.Obelisk.Pretty where

-- | Pretty printer
class Pretty p where
   pretty' :: p     -- ^ To be pretty printed 
           -> Int   -- ^ Tab depth
           -> ShowS -- ^ Shown, waiting for a string to be joined to the end.

instance Pretty String where
   pretty' s i = pspace i . (s ++)

-- | Space before a pretty printed line
pspace :: Int -> ShowS 
pspace i = (('\n' : replicate (i * 3) ' ') ++)

-- | Pretty print!
pretty :: Pretty p => p -> String
pretty p = pretty' p (-1) ""
