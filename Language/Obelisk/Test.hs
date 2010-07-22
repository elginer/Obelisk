-- | Run a test on source code.  See tests directory for examples of use.
module Language.Obelisk.Test where

import Language.Obelisk.Error

import Prelude hiding (catch)

import System.FilePath

import System.Directory

import Control.Exception

-- | Test all source files in a stage of the testing process.
test_all :: (ErrorReport a, Show b)
         => String -- ^ The name of the testing process
         -> (FilePath -> String -> Either a b) -- ^ The test
         -> IO ()
test_all process t =
   catch (success >> failure >> putStrLn "\n******AUTOMATIC TESTING PASSED******") 
         (\e -> print (e :: SomeException) >> putStrLn "\n******TESTING FAILED!******")
   where
   test_dir n = joinPath ["tests", process, n]
   success_files = test_files $ test_dir "success"
   failure_files = test_files $ test_dir "failure"
   success = success_files >>= run_tests True
   failure = failure_files >>= run_tests False
   run_tests b = mapM (test process t b)
   test_files dir = fmap (map (combine dir) . filter (not . elem '.')) $ getDirectoryContents dir

-- | Test a source file.  
test :: (ErrorReport a, Show b)
     => String -- ^ The name of the testing process
     -> (FilePath -> String -> Either a b) -- ^ The test
     -> Bool              -- ^ Whether the test is to succeed or to fail.
     -> FilePath -- ^ The file we are to test.  The file must be in the current directory/"name of testing process"
     -> IO () -- ^ Run the test
test process test success fp =
   readFile fp >>= (\src -> do
      putStrLn $ "\n-----------------------------------"
      putStrLn $ "Testing " ++ fp ++ ":"
      approp success $ test fp src)
   
-- | Perform an appropriate action to the test's results
approp :: (ErrorReport a, Show b) => Bool -> Either a b -> IO ()
approp b =
   uncurry either $ 
      if b
         then (error . pretty . report, putStrLn . nl . show)
         else (putStrLn . pretty . report, error . nl . ("ERROR:" ++ ) . nl . show) 
   where
   nl = ('\n' :)
