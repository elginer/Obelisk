-- Ensure parser output is correct
import Language.Obelisk.Parser
import Language.Obelisk.Parser.Monad

import Control.Monad

main = mapM (\ t -> do
   putStrLn $ "\n\nTest: " ++ t ++ "\n\n"
   run_parser parse "Test-suite" t >>= print) tests

tests =
   ["(def howdy x y z ((: x (y x)) (x z))) (howdy 1 2 3)"
   ,"(if x (y) (z))"
   ,"(def a (b))"
   ,"(: a 1)"
   ,"(6 + 3)"
   ,"(if x ((1 + 2)) ((3 + 4)))"
   ,"((("
   ,")))"
   ,"(: def 3)"
   ,"(if : (3) (4))"
   ]
