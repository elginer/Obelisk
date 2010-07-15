-- | A Simple AST, as parsed from source code
module Language.Obelisk.AST.Simple 
   (module Language.Obelisk.AST
   ,CodeFragment (..)
   ,Pretty (..)
   ,SimpleObelisk
   ,SimpleDef
   ,SimpleFDef
   ,SimpleExp
   ,SimpleBlock)
   where

import Language.Obelisk.AST

import Language.Obelisk.AST.Pretty

import Text.Parsec.Pos 

-- | A code fragment displayed in error reporting makes debugging easier for users
data CodeFragment = CodeFragment
   {pos :: SourcePos
   ,code :: String
   }
   deriving Show

instance Pretty CodeFragment where
   pretty c = unlines $
      ["In " ++ show (pos c)
      ,"Near code:"] ++ map ('\t' :) (lines $ code c)

-- | The obelisk AST, where variables are strings, and the metadata is a code fragment near the AST component 
type SimpleObelisk = Obelisk String CodeFragment 

type SimpleFDef = FDef String CodeFragment

type SimpleDef = Def String CodeFragment

type SimpleExp = Exp String CodeFragment

type SimpleBlock = Block String CodeFragment
