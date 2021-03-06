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
