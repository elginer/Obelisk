-- Ensure parser output is correct
import Language.Obelisk.Parser

import qualified Language.Obelisk.Parser.Monad as M

import Control.Monad

main = mapM (\ t -> do
   putStrLn $ "\n\nTest: " ++ t ++ "\n\n"
   putTest $ eparse "Test-suite" t) tests

putTest r = putStrLn $
   case r of
   M.ParseOK ob -> show ob
   M.ParseFail s -> s

tests =
   ["(def howdy x y z ((x y z)))"
   ,"(: y (if x (y) (z)))"
   ,"(def a (b) where ((: b a)))"
   ,"(: a (6 + 3))"
   ,"((("
   ,")))"
   ,"(: a (def x ())"
   ,"(: def 3)"
   ,"(if : (3) (4))"
   ]
