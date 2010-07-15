-- | Pretty printing!
module Language.Obelisk.AST.Pretty where

-- | Pretty printer.  Note:  this is inefficient.  Look at SPJ's work.
class Pretty p where
   pretty :: p -> String
