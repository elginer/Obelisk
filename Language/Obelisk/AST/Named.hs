-- | AST elements with names
module Language.Obelisk.AST.Named where

-- | Polymorphic AST elements with names
class Named ast where
   name :: ast a m -> a

-- | Simpler AST elements with names
class SimpleNamed ast where
   sname :: ast -> String
