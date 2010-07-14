-- | A Simple AST, as parsed from source code
module Language.Obelisk.AST.Simple 
   (module Language.Obelisk.AST
   ,CodeFragment (..)
   ,SimpleObelisk
   ,SimpleStmt
   ,SimpleExp
   ,SimpleReturner
   ,pretty)
   where

import Language.Obelisk.AST

import Text.Parsec.Pos 

-- | A code fragment displayed in error reporting makes debugging easier for users
data CodeFragment = CodeFragment
   {pos :: SourcePos
   ,code :: String
   }
   deriving Show

-- | Pretty should be a class!
pretty :: CodeFragment -> String
pretty c = unlines $
   ["In " ++ show (pos c)
   ,"Near code:"] ++ map ('\t' :) (lines $ code c)

-- | The obelisk AST, where variables are strings, and the metadata is a code fragment near the AST component 
type SimpleObelisk = Obelisk String CodeFragment 

type SimpleStmt = Stmt String CodeFragment

type SimpleExp = Exp String CodeFragment

type SimpleReturner = Returner String CodeFragment
