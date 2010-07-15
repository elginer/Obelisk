-- Ensure parser output is correct
import Language.Obelisk.Parser

import qualified Language.Obelisk.Parser.Monad as M

import Control.Monad

main = 
   run_tests "success" success >> run_tests "failure" failure

run_tests name =
   mapM (\ t -> do
      putStrLn $ "The parser must report " ++ name ++ "!"
      putStrLn $ "\n\nTest:\n" ++ t ++ "\n\n"
      putTest $ eparse name t)

putTest r = putStrLn $
   case r of
   M.ParseOK ob -> show ob
   M.ParseFail s -> s

success =
   ["(def howdy x y z ((x y z)))"
   ,"(def a (b) where ((let b a)))"]

failure =
   ["(let a (6 + 3))"
   ,"((("
   ,")))"
   ,"(let a (def x ())"
   ,"(let def 3)"
   ,"(if let (3) (4))"
   ]
