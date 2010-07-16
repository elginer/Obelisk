-- | Abstract syntax tree for Obelisk
module Language.Obelisk.AST 
   (module Language.Obelisk.AST.Types
   ,Named (..)
   ,Obelisk (..)
   ,FDef (..)
   ,Def (..)
   ,Block (..)
   ,Exp (..))
   where

import Language.Obelisk.AST.Types

-- | AST elements with names
class Named ast where
   name :: ast a m -> a

instance Named Def where
   name d =
      case d of
         FDef f -> name f 
         Constant _ _ v _ -> v

instance Named FDef where
   name (Def _ _ n _ _ _) = n


-- | The obelisk AST is parametrized over a variable type v, and a metadata type m
newtype Obelisk v m = Obelisk [FDef v m]
   deriving Show

-- | Function definition
data FDef v m =
   Def m (QType FType) v [v] (Block v m) [Def v m]
   deriving Show

-- | Definitions
data Def v m =
     -- | Define a function
     FDef (FDef v m)
   | -- | Define a constant
     Constant m (QType Type) v (Exp v m)
   deriving Show

-- | A block of code
data Block v m = Block m [Exp v m] 
   deriving Show

-- | Expressions in obelisk
data Exp v m =
    -- | If the expression is true, then evaluate the first piece of code, else the second
     If m (Exp v m) (Block v m) (Block v m)
   | -- | Function application
     Apply m (Exp v m) [Exp v m]
   | -- | Infix application
     Infix m (Exp v m) v (Exp v m)
   | -- | A variable
     OVar m v
   | -- | An integer
     OInt m Integer
   | -- | A literal boolean
     OBool m Bool
   deriving Show




