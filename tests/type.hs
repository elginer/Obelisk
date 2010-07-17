-- Ensure the type checker is working

import Language.Obelisk.Error

import Language.Obelisk.TypeChecker
import Language.Obelisk.Scoper
import Language.Obelisk.Parser

import Data.Either

main = run_tests "success" True success >> run_tests "failure" False failure

run_tests name should_succeed = mapM $ \test -> do
   putStrLn $ replicate 50 '-'
   putStrLn $ "\nType checker must report " ++ name ++ ":"
   putStrLn $ "\ntest:\n\n" ++ test 
   putStrLn $ either (\ crap -> let crap_report = pretty $ error_join $ map report crap in
                        if should_succeed
                            then error $ crap_report ++ "\n\nTESTING FAILED!\n\nA unit test should have succeeded, but has failed."
                            else crap_report
                     )
                     (\ob ->
                        if should_succeed
                           then "\nSuccess!"
                           else show ob ++ "\n\nTESTING FAILED!\n\nA unit test should have failed, but has succeeded.")
                     (flip echeck joke_env $ scope $ run_parser name test)

success = test_unit norm_success

failure = test_unit norm_failure 

test_unit tests = tests ++ map into_where tests

into_where test = "// Wrap in where clause\n((Void) # def wrapper () where (\n\n" ++ test ++ "\n\n))"

norm_success =
   ["// Function returning Int\n((Int) # def foo (0))"
   ,"// If statement both branches same\n((Int) # def foo ((if true (0) (1))))"
   ,"// Self function application\n((Int -> Int) # def foo x ((foo x)))"
   ,"// Multiple application\n((Int -> Int) # def foo x ((foo x) (bar x)))\n((Int -> Int) # def bar x ((foo x)))"
   ,"// Application inside If\n((Int -> Int) # def foo x (x))\n((Int) # def bar ((if false ((foo 1)) ((foo 2)))))"
   ,"// Multiple expressions inside if\n((Int) # def foo ((if true (1 2 3) (1 2 3 4))))"
   ,"// Empty block returns void\n((Void) # def foo ())"
   ,"// Application in if statement test\n((Bool -> Bool) # def foo x (x))\n((Void) # def bar ((if (foo true) () ())))"
   ,"// Apply function in where clause\n((Int) # def foo ((bar 1)) where (((Int -> Int) # def bar x (x))))"
   ,"// Return constant in where clause\n((Int) # def foo (bar) where ((Int # let bar 0)))"
   ,"// Set constant to self value\n((Int -> Bool) # def foo x (true) where ((Bool # let bar (foo x))))"
   ,"// Set constant to where clause function value\n((Int -> Void) # def foo x () where ((Bool # let bar (baz x)) ((Int -> Bool) # def baz y (true))))"]


norm_failure = 
   ["// Function's type says Int, but returns Bool\n((Int) # def foo (true))"
   ,"// Function returns itself.  Note: no current way to do this!  This should be success.....\n((Int) # def foo (foo))"
   ,"// If statement branches different\n((Int) # def foo ((if true (0) (false))))"
   ,"// Incorrect function self application\n((Int -> Int) # def foo x ((foo true)))"
   ,"// Incorrect multiple application\n((Bool -> Int) # def foo x ((foo x) (bar x)))\n((Int -> Int) # def bar x ((foo x)))"
   ,"// Incorrect application inside If\n((Int -> Bool) # def foo x (x))\n((Int) # def bar ((if false ((foo 1)) ((foo 2)))))"
   ,"// Incorrect multiple expressions inside if\n((Bool) # def foo ((if true (true true 3) (true 2 true 4))))"
   ,"// Empty block returns something other than void\n((Double) # def foo ())"
   ,"// Incorrect application in if statement test\n((Bool -> Int) # def foo x (0))\n((Void) # def bar ((if (foo true) () ())))"
   ,"// Wrong number of formal arguments\n((Int -> Int -> Int) # def foo x (x))\n((Int -> Int) # def bar x y (x))"
   ,"// Wrong number of actual arguments\n((Int -> Int -> Int) # def foo x y (x))\n((Void) # def bar ((foo 1)))\n((Void) # def baz ((foo 1 2 3)))"
   ,"// Incorrectly apply function in where clause\n((Int) # def foo ((bar true)) where (((Int -> Int) # def bar x (x))))"
   ,"// Incorrectly return constant in where clause\n((Bool) # def foo (bar) where ((Int # let bar 0)))"
   ,"// Incorrectly set constant to self value\n((Int -> Bool) # def foo x (true) where ((Int # let bar (foo x))))"
   ,"// Incorrectly set constant to where clause function value\n((Int -> Void) # def foo x () where ((Bool # let bar (baz x)) ((Int -> Int) # def baz y (y))))"]
      
