{-

Copyright 2010 John Morrice

This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License

This file is part of The Obelisk Programming Language.

    The Obelisk Programming Language is free software: you can 
    redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or any later version.

    The Obelisk Programming Language is distributed in the hope that it 
    will be useful, but WITHOUT ANY WARRANTY; without even the implied 
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with The Obelisk Programming Language.  
    If not, see <http://www.gnu.org/licenses/>

-}

{-#
   OPTIONS
   -XFlexibleInstances
#-}

-- | AST elements can be typed
module Language.Obelisk.TypeChecker.Typed 
   (module Language.Obelisk.AST.Scoped
   ,Typed (..)
   ,TypeEnvironment (..)
   ,TypeError (..)
   ,relay
   ,type_correct
   ,filter_correct
   ,unify
   ,unify_types
   ,unify_types'
   ,void_type
   ,bool_type)
   where

import Language.Obelisk.Error 
import Language.Obelisk.AST.Scoped

import Data.Map (Map)

import Control.Arrow

-- | An AST element either has a type, or it will produce a list of type errors and perhaps a type
class Typed ast where
   typeof :: ast -> TypeEnvironment -> (Maybe QType, [TypeError])

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
   | -- | Constants cannot be of type Void
     ConstantCannotBeVoid CodeFragment
      deriving Show

instance ErrorReport [TypeError] where
   report = error_join . map report

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

         ConstantCannotBeVoid cf ->
            error_line "A constant cannot be void" $ report cf
        
-- | Filter all the correct types
filter_correct :: [(Maybe QType, [TypeError])] -> [(Maybe QType, [TypeError])]
filter_correct =
   filter (null . snd)

-- | The type is correct.  Convert to a form used by the type checker.
type_correct :: QType -> (Maybe QType, [TypeError])
type_correct = Just &&& (const [])

-- | An AST element must be unified with a type.  Report any errors in unification.
unify :: (Typed ast, Fragment ast) => QType -> ast -> TypeEnvironment -> [TypeError]
unify ty ex env = unify_types' ty (typeof ex env) $ fragment ex

-- | Type unification, where the state of the second type is in question
unify_types' :: QType -> (Maybe QType, [TypeError]) -> CodeFragment -> [TypeError]
unify_types' ty (mty_ex, ers) cf =
   maybe ers (\ty_ex ->
                maybe ers (: ers) $ unify_types ty ty_ex cf) mty_ex

-- | Type unification.  Can one type be unified with another?  If not, report an error.
unify_types :: QType -> QType -> CodeFragment -> Maybe TypeError 
unify_types ty1 ty2 cf =
   if ty1 == ty2
      then Nothing
      else Just $ WrongType ty1 ty2 cf

-- | Choose next course of action based on a type.   
relay :: (Maybe QType, [TypeError])            -- ^ If there is no type, add these errors, and replace the type with this.
      -> (QType -> (Maybe QType, [TypeError])) -- ^ If there is a type, apply the type to the function, relaying errors.
      -> (Maybe QType, [TypeError])            -- ^ The type we are inspecting
      -> (Maybe QType, [TypeError])            -- ^ The next type
relay bad good typ =
   second ((snd typ)++) $ maybe bad good $ fst typ

-- | The void type
void_type :: QType
void_type = new_type "Void"

-- | Boolean type
bool_type :: QType
bool_type = new_type "Bool" 
