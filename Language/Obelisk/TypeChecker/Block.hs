-- | Typechecking for blocks
module Language.Obelisk.TypeChecker.Block where

import Language.Obelisk.TypeChecker.Typed

instance Typed Block where
   -- The type of the block is the type of the last expression, but try to gather errors from the other expressions
   typeof (Block exps) env =
      case reverse exps of
         (lst:prev) ->
            let es = concat $ map (either snd (const []) . typeof) $ reverse prev
            in  if null es
                   then typeof lst
                   else Left $ either (\(mt, mes) -> (mt, es ++ mes)) (\t -> (Just t, es)) $ typeof lst  
         [] -> Right void_type 

