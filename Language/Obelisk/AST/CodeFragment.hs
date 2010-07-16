-- | Code fragments for nice error reporting
module Language.Obelisk.AST.CodeFragment where

import Language.Obelisk.Error

import Text.Parsec.Pos

-- | A code fragment displayed in error reporting makes debugging easier for users
data CodeFragment = CodeFragment
   {pos :: SourcePos
   ,code :: String
   }
   deriving Show

instance ErrorReport CodeFragment where
   report c = 
      error_lines ["In " ++ show (pos c), "Near code:"] $ 
        error_section $ error_lines (lines $ code c) empty_error

-- | Get a code fragment from the ast
class Fragment ast where
   fragment :: ast -> CodeFragment

-- | A compiler injected code fragment
inject_fragment :: CodeFragment
inject_fragment = CodeFragment (newPos "__Compiler Injected__" 0 0) ""
