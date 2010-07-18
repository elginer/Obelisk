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

{-# OPTIONS
    -XTypeSynonymInstances
#-}
-- | An AST with tables allowing construction of environments for closures.
module Language.Obelisk.AST.Scoped
   (module Language.Obelisk.AST
   ,module Language.Obelisk.AST.CodeFragment
   ,ClosureTable (..)
   ,ClosureEntry (..)
   ,ScopedObelisk
   ,ScopedDef
   ,ScopedFDef
   ,ScopedExp
   ,ScopedBlock)
   where

import Language.Obelisk.AST.CodeFragment
import Language.Obelisk.AST.Simple
import Language.Obelisk.AST

-- | A closure table shows which variables are needed by 'where' and 'lambda' functions for them to evaluate
newtype ClosureTable = ClosureTable [ClosureEntry]
   deriving Show

-- | A closure entry associates a variable or function name with the function in which it was defined (empty string for top-level)
data ClosureEntry = ClosureEntry
   { -- | Where the entry was defined
     where_def :: String
     -- | Name of the entry
   , def_name :: String}
   deriving Show

instance Fragment ScopedDef where
   fragment d =
      case d of
      FDef f                -> fragment f
      Constant (_,cf) _ _ _ -> cf

instance Fragment ScopedFDef where
  fragment (Def (_,cf) _ _ _ _ _) = cf 

instance Fragment ScopedExp where
   fragment e =
      case e of
         If (_, cf) _ _ _ -> cf
         Apply (_, cf) _ _ -> cf
         Infix (_, cf) _ _ _ -> cf
         OVar (_, cf) _ -> cf
         OInt (_, cf) _ -> cf
         OBool (_, cf) _ -> cf

instance Fragment ScopedBlock where
   fragment (Block (_,cf) es) =
      if null es
         then cf
         else fragment $ last es

-- | The scoped AST, with functions having closure tables generated for them.
type ScopedObelisk = Obelisk String (ClosureTable, CodeFragment)

type ScopedFDef = FDef String (ClosureTable, CodeFragment)

type ScopedDef = Def String (ClosureTable, CodeFragment)

type ScopedExp = Exp String (ClosureTable, CodeFragment)

type ScopedBlock = Block String (ClosureTable, CodeFragment)
