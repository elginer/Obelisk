-- | A Simple AST, as parsed from source code
module Language.Obelisk.AST.Simple 
   (module Language.Obelisk.AST
   ,SimpleObelisk)
   where

import Language.Obelisk.AST

import Text.Parsec.Pos 

-- | The obelisk AST, where variables are strings, and the metadata is the source location of the AST component 
type SimpleObelisk = Obelisk String SourcePos

type SimpleStmt = Stmt String SourcePos

type SimpleExp = Exp String SourcePos

type SimpleReturner = Returner String SourcePos
