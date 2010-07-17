{-#
   OPTIONS
   -XTypeSynonymInstances
#-}
-- | Type checking for expressions
module Language.Obelisk.TypeChecker.Expression where

import Language.Obelisk.Error
import Language.Obelisk.TypeChecker.Typed

import Control.Monad
import Control.Arrow

import qualified Data.Map as M

import Data.Maybe

import Debug.Trace

instance Typed ScopedBlock where
   -- The type of the block is the type of the last expression, but try to gather errors from the other expressions
   typeof (Block _ exps) env =
      case reverse exps of
         (lst:prev) ->
            let es = concatMap (snd . (flip typeof env)) prev
                ty_last = typeof lst env
            in  if null es
                   then ty_last
                   else relay ty_last (const ty_last) (Nothing, es)
         [] -> type_correct void_type 

instance Typed ScopedExp where
   -- The type of expressions
   typeof e env =
      case e of

         If (_,cf) test true false -> if_typeof cf test true false env
         Apply (_, cf) exp args    -> apply_typeof cf exp args env
         Infix (_, cf) _ _ _       -> broken_compiler ["TypeChecker: infix application not yet supported."] $ report cf
         OVar (_, cf) v -> 
            -- Either the type of the variable is right there, or the compiler is broken!
            maybe (broken_compiler ["Could not find variable: " ++ v] $ report cf)
                  type_correct
                  (M.lookup v $ types env)
         OInt _ _                  -> type_correct $ new_type "Int"
         OBool _ _                 -> type_correct bool_type
           
{- The typeof a function application
   If the type of the first expression is a function, and each of its formal arguments 
   matches the type of each of its actual arguments, then the result is the return type of the function, relaying any possible errors.
   If the types don't match, then the expression doesn't have the type, and raise type errors accordingly.
-}
apply_typeof :: CodeFragment -> ScopedExp -> [ScopedExp] -> TypeEnvironment -> (Maybe QType, [TypeError])
apply_typeof cf fun args env =
   relay  (Nothing, []) 
          correct_fu_type
          (typeof fun env)
   where
   failure es = (Nothing, es)
   correct_fu_type fu_ty =
      if length formal_arg_types /= length args
         then 
            failure [WrongNumberOfActualArguments (length formal_arg_types) (length args) cf]
         else 
            if length (filter_correct actual_arg_types) == length args
               then
                  (Just $ return_type fu_ty
                  , arg_errors)
               else
                  failure $ concatMap snd $ actual_arg_types
      where
      arg_errors = concat $ zipWith (\ty1 ty2 -> (unify_types' ty1 ty2 cf)) formal_arg_types actual_arg_types
      actual_arg_types = map (flip typeof env) args
      formal_arg_types = arg_types fu_ty
 
{- The typeof an if expression
  If has a type only if the types of both branches are the same
  If errors are produced in working out the types of either, attempt to find a type from either branch and relay on the errors
  If both branches have a type and don't produce errors, but the types aren't the same, create a BranchesDontMatch error
-}
if_typeof :: CodeFragment -> ScopedExp -> ScopedBlock -> ScopedBlock -> TypeEnvironment -> (Maybe QType, [TypeError])
if_typeof cf test true false env =
   -- If there were no type errors caused by the test
   if null test_errs
      then 
         -- The result is the result of compare the branches
         both
      else 
         -- Otherwise the errors must be relayed
         second (test_errs ++) both
   where
   test_errs = unify bool_type test env 
   falset = typeof false env
   -- Compare the branches
   both =
            -- If neither true nor false have a type, then just relay errors
      relay falset
            -- If true has a type...
            (\qtrue ->
                     -- ...but false does not, then the type is the type of the true branch
               relay (Just qtrue, [])
                     (\qfalse -> 
                        -- ...otherwise if both branches have and....
                        if qfalse == qtrue
                           then 
                              -- ...both branches were the same then we have a type!
                              (Just qtrue, [])
                           else 
                              -- But if the branches were not the same, we don't have a type and we raise a branches don't match error.
                              (Nothing, [BranchesDontMatch qtrue qfalse cf]))
                     falset)
            (typeof true env)
