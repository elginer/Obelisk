-- | Tokens for Obelisk
module Language.Obelisk.Lexer.Token where

-- | Obelisk tokens, lexed by the lexer.  See `Language.Obelisk.Lexer`
data Token =
   -- | An integer
   TInt Integer
   | -- | A boolean true
     TTrue
   | -- | A boolean false
     TFalse
   | -- | Begin function definition
     TDef
   | -- | Parenthesis open
     TParOpen
   | -- | Parenthesis closed
     TParClose
   | -- | A variable, or left-fixity function
     TVar String
   | -- | An infix variable, an operator
     TOp String
   | -- | An if statement
     TIf
   | -- | Constant set operator
     TConstant
   | -- | 'where' clause
     TWhere 
   | -- The end of file
     TEOF

instance Show Token where
   show t =
      case t of
         TInt i    -> show i
         TTrue     -> "true"
         TFalse    -> "false"
         TDef      -> "def"
         TParOpen  -> "("
         TParClose -> ")"
         TVar v    -> v
         TOp op    -> op
         TIf       -> "if"
         TConstant -> ":"
         TWhere    -> "where"
         TEOF      -> "end of file"
