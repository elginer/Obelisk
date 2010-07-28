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

{-#
   OPTIONS
   -XTypeSynonymInstances
#-}

-- | Type check definitions
module Language.Obelisk.TypeChecker.Def where

import Language.Obelisk.Error 

import Language.Obelisk.AST.Scoped

import Language.Obelisk.TypeChecker.Typed

import Language.Obelisk.TypeChecker.Expression

import qualified Data.Map as M

import Data.Maybe

import Control.Arrow

-- | Update the type environment with the types described in a where clause
with_where :: [ScopedDef] -> TypeEnvironment -> TypeEnvironment
with_where wh fatev = fatev {types = 
   foldr (uncurry M.insert) 
         (types fatev)
         (map (\w -> (name w, official_type w)) wh)}

-- | The errors from a where clause
where_errors :: [ScopedDef] -> TypeEnvironment -> [TypeError]
where_errors wh tev = 
   concatMap snd $ map (flip typeof tev) wh

instance Typed ScopedFDef where
   -- The type of the function is the functions type, but try to see if there are errors in unification in the where clauses
   typeof (Def (_,cf) typ fun_name fargs bl wh) tev =
      (Just typ, errs)
      where
      errs =
         if length farg_types /= length fargs
            then [WrongNumberOfFormalArguments (length farg_types) (length fargs) cf]
            else where_errors wh new_tev ++ own_errs
      own_errs = unify ret_typ bl new_tev
      (farg_types, ret_typ) = 
         fromMaybe (broken_compiler
                      ["In Language.Obelisk.TypeChecker.Def"
                      , "The function had a simple type which should be accepted by the parser"] $ 
                         error_section $ report cf)
                   (do as <-arg_types typ
                       r <- return_type typ
                       return (as, r))
      new_tev = whfr_tev {types = M.insert fun_name typ $ types whfr_tev}
      whfr_tev = with_where wh with_fargs 
      with_fargs = tev {types = foldr (uncurry M.insert) (types tev) $ zip fargs farg_types}

instance Typed ScopedDef where
   -- The type of the define clause is either the type of the function, or an attempt at unifying the type of the Constant with the type of its Expression
   typeof d env =
      case d of
         FDef f -> typeof f env
         Constant (_, cf) t _ e ->
            let success = (Just t, unify t e env)
            in  case t of
                   QType _ _ (Type tyn) ->
                      if sname tyn == "Void"
                         then (const Nothing) *** (ConstantCannotBeVoid cf :) $ success
                         else success
                   _ -> success
             
