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
   | -- | Local set operator
     LocalSetter
   | -- The end of file
     TEOF
   deriving Show