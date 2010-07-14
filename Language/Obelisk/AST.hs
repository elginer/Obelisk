-- | Abstract syntax tree for Obelisk
module Language.Obelisk.AST where

-- | The obelisk AST is parametrized over a variable type v, and a metadata type m
newtype Obelisk v m = Obelisk [Stmt v m]
   deriving Show

-- | Statements in obelisk
data Stmt v m =
     -- | Define a function
     Def m v [v] (Returner v m)
   | -- | If the expression is true, then evaluate the first piece of code, else the second
     If m (Exp v m) (Returner v m) (Returner v m)
   | -- | Set the local variable v equal to the result of the expression
     SetLocal m v (Exp v m)
   | -- | Set the global variable v equal to the result of the expression
     SetGlobal m v (Exp v m)
   | -- | Evaluate an expression
     StmtExp m (Exp v m)
   deriving Show

-- | If a piece of code is to return a value, the last item must be an expression
data Returner v m = Returner m [Stmt v m] 
   deriving Show

-- | Expressions in obelisk
data Exp v m =
     -- | Function application
     Apply m (Exp v m) [Exp v m]
   | -- | Infix application
     Infix m (Exp v m) v (Exp v m)
   | -- | A variable
     OVar m v
   | -- | An integer
     OInt m Integer
   | -- | A literal boolean
     OBool m Bool
   deriving Show
