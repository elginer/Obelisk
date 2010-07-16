-- | Types
module Language.Obelisk.AST.Types where

import Language.Obelisk.Error

-- | A quantified type
data QType typ = QType 
   { -- | Code fragment for the type
     tcf :: CodeFragment
   , -- | Type variables used in this type
     tvars :: [String]
   , -- | The type
     typ :: typ}
   deriving (Show, Eq)

-- | A function's type
data FType =
     -- | Multiple type names for a function
     Function [TypeName]
   deriving (Show, Eq)

-- | A simple data type
data Type =
     -- | One type name for a simpler data type
     Type TypeName
   deriving (Show, Eq)

-- | A type name
data TypeName = 
   TypeClassName String
   | TypeVar String
   deriving Show

-- Compare Obelisk types with different Haskell types
class TypeComparison ty1 ty2 where
   (@==) :: QType ty1 -> QType ty2 -> Bool

instance TypeComparison Type Type where
   qt1 @== qt2 = qt1 == qt2

instance TypeComparison FType Type where
   _ (@==) _ = False

instance TypeComparison Type FType where
   _ (@==) _ = False

instance TypeComparison FType FType where
   qt1 @== qt2 = qt1 == qt2

-- | The return type of a function's type
return_type :: QType FType -> QType Type
return_type qtyp@(QType cf vs (FType typs)) =
   if null typs
      then error $ pretty $ error_lines ["Broken compiler!", "The function had no return type!"] $ error_section $ fragment_error cf
      else QType vs (Type $ [last typs])
