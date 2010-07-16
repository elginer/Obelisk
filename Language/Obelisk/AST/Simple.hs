{-# OPTIONS
    -XTypeSynonymInstances
#-}
-- | A Simple AST, as parsed from source code
module Language.Obelisk.AST.Simple 
   (module Language.Obelisk.AST
   ,module Language.Obelisk.AST.CodeFragment
   ,SimpleObelisk
   ,SimpleDef
   ,SimpleFDef
   ,SimpleExp
   ,SimpleBlock)
   where

import Language.Obelisk.AST
import Language.Obelisk.CodeFragment

import Text.Parsec.Pos 

instance Fragment SimpleFDef where
   fragment (Def f _ _ _ _ _) = f 

-- | The obelisk AST, where variables are strings, and the metadata is a code fragment near the AST component 
type SimpleObelisk = Obelisk String CodeFragment 

type SimpleFDef = FDef String CodeFragment

type SimpleDef = Def String CodeFragment

type SimpleExp = Exp String CodeFragment

type SimpleBlock = Block String CodeFragment
