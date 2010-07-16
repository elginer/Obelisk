-- | Abstract syntax tree for Obelisk
module Language.Obelisk.AST 
   (module Language.Obelisk.AST.Types
   ,Named (..)
   ,SimpleNamed (..)
   ,Obelisk (..)
   ,FDef (..)
   ,Def (..)
   ,Block (..)
   ,Exp (..)
   ,official_type)
   where

import Language.Obelisk.AST.Types
import Language.Obelisk.AST.Named

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
   Def m QType v [v] (Block v m) [Def v m]
   deriving Show

-- | Definitions
data Def v m =
     -- | Define a function
     FDef (FDef v m)
   | -- | Define a constant
     Constant m QType v (Exp v m)
   deriving Show

-- | The 'official' type of a definition
official_type :: Def v m -> QType
official_type d =
   case d of
      FDef (Def _ qt _ _ _ _) -> qt
      Constant _ qt _ _ -> qt

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



