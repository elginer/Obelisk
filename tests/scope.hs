-- | Check the scoper works
import Language.Obelisk.Scoper
import Language.Obelisk.Parser

main = run_tests "success" success >> run_tests "failure" failure

run_tests name =
   mapM_ $ \t -> do
      putStrLn $ "\n\nThe scoper must report " ++ name ++ "!"
      putStrLn $ "Test: " ++ t
      case escope $ run_parser name t of
         Right ob -> print ob
         Left err -> putStrLn err
      putStrLn "\n\n"

success =
   ["// The define can see itself\n(def x (x))"
   ,"// The second define can see the first \n(def x ())\n(def y (x))"
   ,"// The first define can see the second\n(def x (y))\n(def y ())"
   ,"// Each define can see the other\n(def x (y))\n(def y (x))"
   ,"// The define can see its inner constant\n(def x (y) where ((: y 3)))"
   ,"// The define can see its inner define\n(def x (y) where ((def y ())))"
   ,"// The define can see its argument\n(def x y (y))"
   ,"// The define's inner constant can see its argument\n(def x y () where ((: z y)))"
   ,"// The define's inner define can see its argument\n(def x y () where ((def z (y))))"
   ,"// The define's inner define has an inner define that can see its argument\n(def x y () where ((def z () where ((def q (y))))))"
   ,"// A def in a where clause can see other defs\n(def x () where ((def y (z))(def z (y))))"
   ,"// A constant in a where clause can see defs\n(def x () where ((: y z) (def z ())))"
   ]

failure =
   ["// A lonesome define cannot see anyone else\n(def x (y))"
   ,"// A define cannot see another's where clause\n(def x () where ((: z 0)))\n(def y (z))"
   ,"// In a where clause a define cannot see constants\n(def x () where ((: z 0) (def y (z))))"
   ,"// A constant in a where clause cannot see other constants\n(def x () where ((: z 0) (: y z)))"
   ,"// Two top level functions cannot have the same name\n(def x ()) (def x ())"
   ,"// Two where clause members cannot share the same name\n(def x () where ((: y 0) (: y 1)))"
   ,"// A where clause member cannot share the same name as a function's argument\n(def x y () where ((: y 0)))"
   ]
