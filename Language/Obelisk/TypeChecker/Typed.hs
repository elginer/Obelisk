-- | AST elements can be typed
module Language.Obelisk.TypeChecker.Typed 
   (module Language.Obelisk.AST.Scoped
   ,Typed (..)
   ,TypeEnvironment (..)
   ,TypeError (..)
   ,unify
   ,new_type
   ,void_type
   ,bool_type)
   where

import Language.Obelisk.AST.Scoped

import qualified Data.Map as M

-- | An AST element either has a type, or it will produce a list of type errors and perhaps a type
class Typed ast where
   typeof :: ast -> TypeEnvironment -> Either (Maybe QType, [TypeError]) QType

-- | Type environment
data TypeEnvironment = TypeEnvironment
   { -- | Known types
     types :: Map String QType}

-- | Type errors resulting from drunken programming
data TypeError =
     -- | The first type was expected, but the second type was recieved
     WrongType QType QType CodeFragment
   | -- | The type signature for a function had a different number of arguments than given in the code
     WrongNumberOfFormalArguments Int Int CodeFragment
   | -- | The branches of an if statement do not match
     BranchesDontMatch QType QType CodeFragment
   | -- | Something is wrong with the compiler!
     BrokenCompiler String CodeFragment

-- | One type may unify with another
unify :: Typed ast => QType -> ast -> CodeFragment -> Either (Maybe QType, [TypeError]) QType 
unify t e cf =
   either (Left . more_errors) correct_type $ typeof e
   where
   correct_type et =
      if t @== et
         then Right t
         else Left (Just t, [WrongType t et]
   -- Perhaps there are more errors to come....
   more_errors (mt, ers) =
      maybe (Just t, ers) 
            (\et ->
               if t == et
                  then (Just t, ers)
                  else (Just t, WrongType t et : ers)  
            mt

-- | The void type
void_type :: QType
void_type = new_type "Void"

-- | Boolean type
bool_type :: QType
bool_type = new_type "Bool" 

-- | Create a new type
new_type :: String -> QType 
new_type name = QType [] $ Type [TypeClassName name]
