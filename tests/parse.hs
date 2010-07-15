-- Ensure parser output is correct
import Language.Obelisk.Parser

import qualified Language.Obelisk.Parser.Monad as M

import Control.Monad

main = 
   run_tests "success" success >> run_tests "failure" failure

run_tests name =
   mapM (\ t -> do
      putStrLn $ "The parser must report " ++ name ++ "!"
      putStrLn $ "\n\nTest: " ++ t ++ "\n\n"
      putTest $ eparse name t)

putTest r = putStrLn $
   case r of
   M.ParseOK ob -> show ob
   M.ParseFail s -> s

success =
   ["(def howdy x y z ((x y z)))"
   ,"(def a (b) where ((: b a)))"]

failure =
   ["(: a (6 + 3))"
   ,"((("
   ,")))"
   ,"(: a (def x ())"
   ,"(: def 3)"
   ,"(if : (3) (4))"
   ]
