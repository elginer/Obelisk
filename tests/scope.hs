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

-- | Check the scoper works
import Language.Obelisk.Scoper
import Language.Obelisk.Parser

main = run_tests "success" success >> run_tests "failure" failure

run_tests name =
   mapM_ $ \t -> do
      putStrLn $ "\n\nThe scoper must report " ++ name ++ ":"
      putStrLn $ "\n\nTest:\n " ++ t
      case escope $ run_parser name t of
         Right ob -> print ob
         Left err -> putStrLn err
      putStrLn "\n\n"

success =
   ["// The define can see itself\n(A # def x (x))"
   ,"// The second define can see the first \n(A # def x ())\n(A # def y (x))"
   ,"// The first define can see the second\n(A # def x (y))\n(A # def y ())"
   ,"// Each define can see the other\n(A # def x (y))\n(A # def y (x))"
   ,"// The define can see its inner constant\n(A # def x (y) where ((A # let y 3)))"
   ,"// The define can see its inner define\n(A # def x (y) where ((A # def y ())))"
   ,"// The define can see its argument\n(A # def x y (y))"
   ,"// The define's inner constant can see its argument\n(A # def x y () where ((A # let z y)))"
   ,"// The define's inner define can see its argument\n(A # def x y () where ((A # def z (y))))"
   ,"// The define's inner define has an inner define that can see its argument\n(A # def x y () where ((A # def z () where ((A # def q (y))))))"
   ,"// A def in a where clause can see other defs\n(A # def x () where ((A # def y (z)) (A # def z (y))))"
   ,"// A constant in a where clause can see defs\n(A # def x () where ((A # let y z) (A # def z ())))"
   ]

failure =
   ["// A lonesome define cannot see anyone else\n(A # def x (y))"
   ,"// A define cannot see another's where clause\n(A # def x () where ((A # let z 0)))\n(A # def y (z))"
   ,"// In a where clause a define cannot see constants\n(A # def x () where ((A # let z 0) (A # def y (z))))"
   ,"// A constant in a where clause cannot see other constants\n(A # def x () where ((A # let z 0) (A # let y z)))"
   ,"// Two top level functions cannot have the same name\n(A # def x ()) (A # def x ())"
   ,"// Two where clause members cannot share the same name\n(A # def x () where ((A # let y 0) (A # let y 1)))"
   ,"// A where clause member cannot share the same name as a function's argument\n(A # def x y () where ((A # let y 0)))"
   ]
