-- | Code fragments for nice error reporting
module Language.Obelisk.AST.CodeFragment where

import Language.Obelisk.Error

-- | A code fragment displayed in error reporting makes debugging easier for users
data CodeFragment = CodeFragment
   {pos :: SourcePos
   ,code :: String
   }
   deriving Show

-- | Get a code fragment from the ast
class Fragment ast where
   fragment :: ast -> CodeFragment

-- | Start an error with a display of a code fragment
fragment_error :: CodeFragment -> CompilerError
fragment_error = 
   error_lines ["In " ++ show (pos c), "Near code:"] $ 
     error_section $ error_lines (lines $ code c) empty_error

