-- | The Obelisk programming language
module Language.Obelisk where

import Prelude hiding (lex)

import Language.Obelisk.Parser
import Language.Obelisk.Scoper
import Language.Obelisk.TypeChecker
import Language.Obelisk.Emitter

import System.FilePath

import Control.Monad

-- | Compile a source file
compile_file :: FilePath -> IO ()
compile_file f = do
   readFile source >>= (compile source >=> writeFile (addExtension source "c"))
   where
   source = 
      if takeExtension f == "obk"
         then f
         else addExtension f "obk"

-- | Perform all compilations, go from serialized input source to serialized output target.
compile :: FilePath -> String -> IO String
compile fp i = do
   putStrLn $ "Compiling " ++ fp ++ "..."
   return $ emit $ check $ scope $ run_parser fp i 
