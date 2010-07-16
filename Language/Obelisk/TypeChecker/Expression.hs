-- | Type checking for expressions
module Language.Obelisk.TypeChecker.Expression

import Language.Obelisk.TypeChecker.Typed

instance TypeOf ScopedExp where
   -- The type of expressions
   typeof e env =
      case e of

         If (_,cf) test true false -> if_typeof cf test true false
         Apply (_, cf) exp args    -> apply_typeof cf exp args
         Infix _ _ _ _             -> error "TypeChecker: infix application not yet supported"
         OVar (_, cf) v -> 
            -- Either the type of the variable is right there, or the compiler is broken!
            maybe (Nothing, [BrokenCompiler ("Could not find variable: " ++ v) cf]) 
                  Right
                  (M.lookup v $ types env)
         OInt _ _                  -> Right $ new_type "Int"
         OBool _ _                 -> Right $ bool_type
           
{- The typeof a function application
   If the type of the first expression is 
-}
 
{- The typeof an if expression
  If has a type only if the types of both branches are the same
  If errors are produced in working out the types of either, attempt to find a type from either branch and relay on the errors
  If both branches have a type and don't produce errors, but the types aren't the same, create a BranchesDontMatch error
-}
if_typeof :: CodeFragment -> ScopedExp -> Block String m -> Block String m -> Either (Maybe QType, [TypeError]) QType
if_typeof cf test true false =
   -- If there were no type errors caused by the test
   if null test_errs
      then 
         -- The result is the result of compare the branches
         eboth
      else 
         -- Otherwise the errors must be relayed
         either (second (test_errs ++)) (\t -> (Just t, test_errs)) efalse
   where
   test_errs = either snd (const []) $ unify bool_type test $ fragment test
   etrue = typeof true
   eboth = 
      either (\ft ->
                either (\fr -> 
                          -- Both branches are bad
                          (msum [fst ft, fst fr], snd ft ++ snd fr))
                       (\t  -> 
                          -- The false branch is good, the true branch is bad
                          (Just t, snd ft)) 
                       (typeof false))
             (\tt ->
                either (\lf  ->
                          -- The true branch is good, the false is bad
                          (Just tt, snd lf))
                       (\rf  ->
                          -- Both branches are good but....
                          if rf == tt
                             then 
                                -- ...both branches were the same
                                Right rf
                             else 
                                -- ...the branches were not the same
                                Left (Nothing, [BranchesDontMatch tt rf $ fragment exp]))
                       (typeof false))
             etrue
