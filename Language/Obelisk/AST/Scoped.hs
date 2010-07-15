{-# OPTIONS
    -XTypeSynonymInstances
#-}
-- | An AST with tables allowing construction of environments for closures.
module Language.Obelisk.AST.Scoped
   (module Language.Obelisk.AST
   ,Fragment (..)
   ,ClosureTable (..)
   ,ClosureEntry (..)
   ,CodeFragment (..)
   ,Pretty (..)
   ,ScopedObelisk
   ,ScopedDef
   ,ScopedExp
   ,ScopedBlock)
   where

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
      FDef f              -> fragment f
      Constant (_,cf) _ _ -> cf

instance Fragment ScopedFDef where
  fragment (Def (_,cf) _ _ _ _) = cf 

-- | The scoped AST, with functions having closure tables generated for them.
type ScopedObelisk = Obelisk String (ClosureTable, CodeFragment)

type ScopedFDef = FDef String (ClosureTable, CodeFragment)

type ScopedDef = Def String (ClosureTable, CodeFragment)

type ScopedExp = Exp String (ClosureTable, CodeFragment)

type ScopedBlock = Block String (ClosureTable, CodeFragment)
