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

import Prelude hiding (readFile)

import System.Environment
import Data.ByteString.Char8 hiding (putStrLn, unlines)

import System.IO hiding (readFile, hGetContents) 

main = do
   (cs:cf:as) <- getArgs 
   copy <- readFile "permission"
   mapM (add_notice cs cf copy) as

add_notice comment_start comment_finish copy fp = do
   putStrLn $ "Going to read " ++ fp
   code <- readFile fp 
   src <- openFile fp WriteMode 
   mapM (hPut src) [pack comment_start, pack "\n\n", notice, copy, singleton '\n', pack comment_finish, pack "\n\n", code]
   hClose src

notice = pack $ unlines
   ["Copyright 2010 John Morrice"
   ,""
   ,"This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License"
   ,""]
