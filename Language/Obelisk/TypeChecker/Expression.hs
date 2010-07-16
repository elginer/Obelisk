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

import Data.Either

instance Typed ScopedBlock where
   -- The type of the block is the type of the last expression, but try to gather errors from the other expressions
   typeof (Block _ exps) env =
      case reverse exps of
         (lst:prev) ->
            let es = concat $ map (either snd (const []) . (flip typeof env)) $ reverse prev
            in  if null es
                   then typeof lst env
                   else Left $ either (\(mt, mes) -> (mt, es ++ mes)) (\t -> (Just t, es)) $ typeof lst env  
         [] -> Right void_type 

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
                  Right
                  (M.lookup v $ types env)
         OInt _ _                  -> Right $ new_type "Int"
         OBool _ _                 -> Right $ bool_type
           
{- The typeof a function application
   If the type of the first expression is a function, and each of its formal arguments 
   matches the type of each of its actual arguments, then the result is the return type of the function, relaying any possible errors.
   If the types don't match, then the expression doesn't have the type, and raise type errors accordingly.
-}
apply_typeof :: CodeFragment -> ScopedExp -> [ScopedExp] -> TypeEnvironment -> Either (Maybe QType, [TypeError]) QType
apply_typeof cf fun args env =
   either (\(mfu_ty, ers) ->
          maybe (failure ers) 
                (\fu_ty -> Left $
                   either (second (++ ers))
                          (\ap_ty ->
                             (Just ap_ty, ers)) 
                          (correct_fu_type fu_ty))
                mfu_ty) 
          correct_fu_type 
          (typeof fun env)
   where
   failure es = Left (Nothing, es)
   correct_fu_type fu_ty =
      if length fty_args /= length args
         then 
            failure [WrongNumberOfActualArguments (length fty_args) (length args) cf]
         else 
            if length (rights actual_arg_types) == length args
               then 
                  failure $ concatMap snd $ lefts actual_arg_types
               else
                  Right $ return_type fu_ty
      where
      actual_arg_types = map (flip typeof env) args
      fty_args = arg_types fu_ty
 
{- The typeof an if expression
  If has a type only if the types of both branches are the same
  If errors are produced in working out the types of either, attempt to find a type from either branch and relay on the errors
  If both branches have a type and don't produce errors, but the types aren't the same, create a BranchesDontMatch error
-}
if_typeof :: CodeFragment -> ScopedExp -> ScopedBlock -> ScopedBlock -> TypeEnvironment -> Either (Maybe QType, [TypeError]) QType
if_typeof cf test true false env =
   -- If there were no type errors caused by the test
   if null test_errs
      then 
         -- The result is the result of compare the branches
         eboth
      else 
         -- Otherwise the errors must be relayed
         Left $ either (second (test_errs ++)) (\t -> (Just t, test_errs)) eboth
   where
   test_errs = either snd (const []) $ unify bool_type test env 
   eboth = 
      either (\ft -> Left $
                either (\fr -> 
                          -- Both branches are bad
                          (msum [fst ft, fst fr], snd ft ++ snd fr))
                       (\t  -> 
                          -- The false branch is good, the true branch is bad
                          (Just t, snd ft)) 
                       (typeof false env))
             (\lbt ->
                either (\rf  ->
                          -- The true branch is good, the false is bad
                          Left (Just lbt, snd rf))
                       (\rbt  ->
                          -- Both branches are good but....
                          if rbt == lbt
                             then 
                                -- ...both branches were the same
                                Right rbt
                             else 
                                -- ...the branches were not the same
                                Left (Nothing, [BranchesDontMatch lbt rbt cf]))
                       (typeof false env))
             (typeof true env)
