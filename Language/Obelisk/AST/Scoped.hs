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
