{-

Copyright 2010 John Morrice

This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License

This file is part of The Obelisk Programming Language.

    The Obelisk Programming Language is free software: you can 
    redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or any later version.

    The Obelisk Programming Language is distributed in the hope that it 
    will be useful, but WITHOUT ANY WARRANTY; without even the implied 
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with The Obelisk Programming Language.  
    If not, see <http://www.gnu.org/licenses/>

-}

{-#
   OPTIONS
   -XMultiParamTypeClasses
#-}
-- | Types
module Language.Obelisk.AST.Types where

import Language.Obelisk.Pretty

import Language.Obelisk.AST.CodeFragment
import Language.Obelisk.AST.Named

import Language.Obelisk.Error

import Data.List

-- | A quantified type
data QType = QType 
   { -- | Code fragment for the type
     tcf :: CodeFragment
   , -- | Type variables used in this type
     tvars :: [String]
   , -- | The type
     typ :: Type}
   deriving Show

instance Pretty QType where
   pretty' qt =
      pretty' (typ qt)

instance Fragment QType where
   fragment = tcf

instance Eq QType where
   qt1 == qt2 = 
      tvars qt1 == tvars qt1 && typ qt1 == typ qt2

-- | A function's type
data Type =
     -- | Multiple type names for a function
     Function [TypeName]
   | -- | One type name for a simpler data type
     Type TypeName
   deriving (Show, Eq)

instance Pretty Type where
   pretty' typ i = ((pspace i) .) 
      (case typ of
         Type tn -> ((sname tn) ++)
         Function ts -> ('(' :) . foldr (.) id (intersperse (" -> " ++) $ map ((++) . sname) ts) . (')' :))

-- | A type name
data TypeName = 
   TypeClassName String
   | TypeVar String
   deriving (Show, Eq)

instance SimpleNamed TypeName where
   sname (TypeClassName nm) = nm
   sname (TypeVar nm) = nm

-- | The type of the function was broken
broken_function_type :: QType -> a
broken_function_type typ = broken_compiler ["The function had a simple, rather than function type!"] $ report $ fragment typ

-- | The return type of a function's type
return_type :: QType -> QType
return_type qtyp@(QType cf vs typ) =
   case typ of
      Type _ -> broken_function_type qtyp 
      Function typs ->
         if null typs
            then broken_compiler ["The function had no return type!"] $ error_section $ report cf
            else QType cf vs (Type $ last typs)

-- | The list of types of a function's type's arguments
arg_types :: QType -> [QType] 
arg_types typ@(QType _ _ unqtyp) =
   case unqtyp of
      Type _ -> broken_function_type typ
      Function ts -> 
         map (new_type . sname) $ take (length ts - 1) ts

-- | Create a new simple type
new_type :: String -> QType
new_type name = QType inject_fragment [] $ Type (TypeClassName name)

-- | Create a new function type
new_ftype :: [String] -> QType
new_ftype = QType inject_fragment [] . Function . map TypeClassName
