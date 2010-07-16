-- Ensure parser output is correct
import Language.Obelisk.Parser

import qualified Language.Obelisk.Parser.Monad as M

import Control.Monad

main = 
   run_tests "success" success >> run_tests "failure" failure

run_tests name =
   mapM (\ t -> do
      putStrLn $ "\n\nThe parser must report " ++ name ++ ":"
      putStrLn $ "\n\nTest:\n" ++ t ++ "\n\n"
      putTest $ eparse name t)

putTest r = putStrLn $
   case r of
   M.ParseOK ob -> show ob
   M.ParseFail s -> s

success =
   ["(A # def howdy x y z ((x y z)))"
   ,"(A # def a (b) where ((A # let b a)))"
   ,"(Int -> Double -> TripleVodka # def a ())"
   ,"(A # def x () where ((Int -> Double # let z a)))"
   ]

failure =
   ["(A # let a (6 + 3))"
   ,"((("
   ,")))"
   ,"(A # let a (def x ())"
   ,"(A # let def 3)"
   ,"(A # if let (3) (4))"
   ]
