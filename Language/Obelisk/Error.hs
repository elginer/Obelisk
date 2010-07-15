-- | Nice looking compiler errors where
module Language.Obelisk.Error where

-- | A nice looking compiler error
compiler_error :: String -- ^ The name of the error
               -> String -- ^ The error text
               -> String -- ^ A nice looking error message
compiler_error name text =
   unlines $
         ("\n\t" ++ name) : map ("\t\t" ++) (lines text)

