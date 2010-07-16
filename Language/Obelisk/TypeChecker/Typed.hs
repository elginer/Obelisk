-- | AST elements can be typed
module Language.Obelisk.TypeChecker.Typed 
   (module Language.Obelisk.AST.Scoped
   ,Typed (..)
   ,TypeEnvironment (..)
   ,TypeError (..)
   ,unify
   ,void_type
   ,bool_type)
   where

import Language.Obelisk.Error
import Language.Obelisk.AST.Scoped

import Data.Map (Map)

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
   | -- | An incorrect number of arguments was applied to a function
     WrongNumberOfActualArguments Int Int CodeFragment
   | -- | The branches of an if statement do not match
     BranchesDontMatch QType QType CodeFragment

instance ErrorReport TypeError where
   report ty_err = error_line "Type error:" $ error_section $
      case ty_err of
         WrongType t1 t2 cf ->
            error_lines ["Wrong type.", "The type expected was:"] $
            error_line t1 $
            error_line "But the type received was:" $
            error_line t2 $
               error_section $ report cf

         WrongNumberOfFormalArguments ty_args fo_args cf ->
            error_lines ["The number of arguments in a function's type signature"
                        ,"is different from the number of arguments in its implementation."
                        ,"The type signature has " ++ show ty_args ++ " arguments."
                        ,"The implementation has " ++ show fo_args ++ " arguments."] $ error_section $ report cf
 
         WrongNumberOfActualArguments fo_args ac_args cf ->
            error_lines ["The number of arguments applied to a function is not equal to the number of arguments the function has."
                        ,"The function has " ++ show fo_args ++ " arguments,"
                        ,"but " ++ show ac_args ++ " arguments were applied."] $ report cf

         BranchesDontMatch trueb falseb cf ->
            error_lines ["The two branches of an if statement did not have the same type"
                       ,"The type of the 'true' branch was:"] $
            error_line trueb $ 
            error_line "But the type of the 'false' branch was:" $
            error_line falseb $ report cf
        
-- | One type may unify with another
unify :: (Typed ast, Fragment ast) => QType -> ast -> TypeEnvironment -> Either (Maybe QType, [TypeError]) QType
unify ty ex env =
   either (Left . more_errors) correct_type $ typeof ex env
   where
   correct_type ext =
      if ty == ext
         then Right ty
         else Left (Just ty, [WrongType ty ext $ fragment ex])
   -- Perhaps there are more errors to come....
   more_errors (mext, ers) =
      maybe (Just ty, ers) 
            (\ext ->
               if ty == ext
                  then (Just ty, ers)
                  else (Just ty, WrongType ty ext (fragment ex) : ers))  
            mext

-- | The void type
void_type :: QType
void_type = new_type "Void"

-- | Boolean type
bool_type :: QType
bool_type = new_type "Bool" 
