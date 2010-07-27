{-# OPTIONS  #-}


-- parser (data) produced by Happy (GLR) Version 1.18.4

module Data where

-- | Parser for obelisk.  Generated by happy.  See happy/obelisk.y
module Language.Obelisk.Parser where

import Prelude hiding (lex)

import Language.Obelisk.Parser.Monad hiding (eparse, run_parser)
import qualified Language.Obelisk.Parser.Monad as M

import Language.Obelisk.Lexer
import Language.Obelisk.Lexer.Token

import Language.Obelisk.AST.Simple

parse :: Parse

terror :: Token -> OParser a
terror = fail . ("Caused by token: " ++) . show 

-- Convienence parsers
run_parser :: FilePath -> String -> SimpleObelisk
run_parser = M.run_parser parse

eparse :: FilePath -> String -> ParseResult SimpleObelisk
eparse = M.eparse parse


{-# LINE 1 "templates/GLR_Base.lhs" #-}
{-# LINE 1 "/tmp/ghc6289_0/ghc6289_0.lpp" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc6289_0/ghc6289_0.lpp" #-}
{-# LINE 1 "templates/GLR_Base.lhs" #-}









 type ForestId  = (Int,Int,GSymbol)





 data GLRAction = Shift Int [Reduction]
                | Reduce [Reduction]
                | Accept
                | Error 






 type Reduction = (GSymbol,Int, [ForestId] -> Branch)





 data Branch
  = Branch {b_sem :: GSem, b_nodes :: [ForestId]}
    deriving Show

 instance Eq Branch where
        b1 == b2 = b_nodes b1 == b_nodes b2













 class TreeDecode a where
        decode_b :: (ForestId -> [Branch]) -> Branch -> [Decode_Result a]

 decode :: TreeDecode a => (ForestId -> [Branch]) -> ForestId -> [Decode_Result a]
 decode f i@(_,_,HappyTok t) 
   = decode_b f (Branch (SemTok t) [])
 decode f i
   = [ d | b <- f i, d <- decode_b f b ]








 --cross_fn :: [a -> b] -> [a] -> [b]
 --actual type will depend on monad in use. 
 --happy_ap defined by parser generator
 cross_fn fs as = [ f `happy_ap` a | f <- fs, a <- as]








 class LabelDecode a where
        unpack :: GSem -> a








{-# LINE 126 "Data.hs"#-}



{-# LINE 130 "Data.hs"#-}

data GSymbol = HappyEOF | HappyTok {-!Int-} (Token) | G_Pos 
 | G_QType 
 | G_FQType 
 | G_SQType 
 | G_FType 
 | G_SType 
 | G_ArgTypes 
 | G_TypeNames 
 | G_TypeName 
 | G_Obelisk 
 | G_FDefs 
 | G_Defs 
 | G_FDef 
 | G_Def 
 | G_WhereClause 
 | G_Vars 
 | G_If 
 | G_TExp 
 | G_Exp 
 | G_PExp 
 | G_Apply 
 | G_Exps 
 | G_Infix 
 | G_Var 
 | G_Int 
 | G_Bool 
 | G_Char 
 | G_Block 
   deriving (Show,Eq,Ord)

data GSem
 = NoSem
 | SemTok (Token)
 | Sem_0 (OParser (CodeFragment)) 
 | Sem_1 (QType -> OParser (QType)) 
 | Sem_2 (CodeFragment -> Type -> OParser (QType)) 
 | Sem_3 (Type -> OParser (Type)) 
 | Sem_4 (TypeName -> OParser (Type)) 
 | Sem_5 ([TypeName] -> OParser (Type)) 
 | Sem_6 ([TypeName] -> TypeName -> OParser ([TypeName])) 
 | Sem_7 (TypeName -> OParser ([TypeName])) 
 | Sem_8 (Token -> OParser (TypeName)) 
 | Sem_9 ([SimpleFDef] -> OParser (SimpleObelisk)) 
 | Sem_10 ([SimpleFDef] -> SimpleFDef -> OParser ([SimpleFDef])) 
 | Sem_11 (OParser ([SimpleFDef])) 
 | Sem_12 ([SimpleDef] -> SimpleDef -> OParser ([SimpleDef])) 
 | Sem_13 (OParser ([SimpleDef])) 
 | Sem_14 (CodeFragment -> QType -> Token -> [String] -> SimpleBlock -> [SimpleDef] -> OParser (SimpleFDef)) 
 | Sem_15 (SimpleFDef -> OParser (SimpleDef)) 
 | Sem_16 (CodeFragment -> QType -> Token -> SimpleExp -> OParser (SimpleDef)) 
 | Sem_17 ([SimpleDef] -> OParser ([SimpleDef])) 
 | Sem_18 (OParser ([String])) 
 | Sem_19 ([String] -> Token -> OParser ([String])) 
 | Sem_20 (CodeFragment -> SimpleExp -> SimpleBlock -> SimpleBlock -> OParser (SimpleExp)) 
 | Sem_21 (SimpleExp -> OParser (SimpleExp)) 
 | Sem_22 (SimpleExp -> OParser (SimpleExp)) 
 | Sem_23 (CodeFragment -> SimpleExp -> [SimpleExp] -> OParser (SimpleExp)) 
 | Sem_24 (OParser ([SimpleExp])) 
 | Sem_25 ([SimpleExp] -> SimpleExp -> OParser ([SimpleExp])) 
 | Sem_26 (CodeFragment -> SimpleExp -> Token -> SimpleExp -> OParser (SimpleExp)) 
 | Sem_27 (CodeFragment -> Token -> OParser (SimpleExp)) 
 | Sem_28 (CodeFragment -> OParser (SimpleExp)) 
 | Sem_29 (CodeFragment -> [SimpleExp] -> [SimpleDef] -> OParser (SimpleBlock)) 
instance Show GSem where
	show Sem_0{} = "Sem_0"
	show Sem_1{} = "Sem_1"
	show Sem_2{} = "Sem_2"
	show Sem_3{} = "Sem_3"
	show Sem_4{} = "Sem_4"
	show Sem_5{} = "Sem_5"
	show Sem_6{} = "Sem_6"
	show Sem_7{} = "Sem_7"
	show Sem_8{} = "Sem_8"
	show Sem_9{} = "Sem_9"
	show Sem_10{} = "Sem_10"
	show Sem_11{} = "Sem_11"
	show Sem_12{} = "Sem_12"
	show Sem_13{} = "Sem_13"
	show Sem_14{} = "Sem_14"
	show Sem_15{} = "Sem_15"
	show Sem_16{} = "Sem_16"
	show Sem_17{} = "Sem_17"
	show Sem_18{} = "Sem_18"
	show Sem_19{} = "Sem_19"
	show Sem_20{} = "Sem_20"
	show Sem_21{} = "Sem_21"
	show Sem_22{} = "Sem_22"
	show Sem_23{} = "Sem_23"
	show Sem_24{} = "Sem_24"
	show Sem_25{} = "Sem_25"
	show Sem_26{} = "Sem_26"
	show Sem_27{} = "Sem_27"
	show Sem_28{} = "Sem_28"
	show Sem_29{} = "Sem_29"


semfn_0_0 ns@(happy_rest) =  Branch (Sem_0 (
		 get_pos)) ns
semfn_1_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_1 (\happy_var_1 -> return (happy_var_1))) ns
semfn_2_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_2 (\happy_var_1 -> \happy_var_2 -> return (QType happy_var_1 [] happy_var_2))) ns
semfn_3_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_3 (\happy_var_2 -> return (happy_var_2))) ns
semfn_4_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_4 (\happy_var_1 -> return (Type happy_var_1))) ns
semfn_5_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_5 (\happy_var_1 -> return (Function $ reverse happy_var_1))) ns
semfn_6_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_rest) =  Branch (Sem_6 (\happy_var_1 -> \happy_var_3 -> return (happy_var_3 : happy_var_1))) ns
semfn_7_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_7 (\happy_var_1 -> return ([happy_var_1]))) ns
semfn_8_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_8 (\(TClassName happy_var_1) -> return (TypeClassName happy_var_1))) ns
semfn_9_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_9 (\happy_var_1 -> return (Obelisk $ reverse happy_var_1))) ns
semfn_10_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_10 (\happy_var_1 -> \happy_var_2 -> return (happy_var_2 : happy_var_1))) ns
semfn_11_0 ns@(happy_rest) =  Branch (Sem_11 (return ([]))) ns
semfn_12_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_12 (\happy_var_1 -> \happy_var_2 -> return (happy_var_2 : happy_var_1))) ns
semfn_13_0 ns@(happy_rest) =  Branch (Sem_13 (return ([]))) ns
semfn_14_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_var_4:happy_var_5:happy_var_6:happy_var_7:happy_rest) =  Branch (Sem_14 (\happy_var_1 -> \happy_var_2 -> \(TVar happy_var_4) -> \happy_var_5 -> \happy_var_6 -> \happy_var_7 -> return (Def happy_var_1 happy_var_2 happy_var_4 happy_var_5 happy_var_6 happy_var_7))) ns
semfn_15_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_15 (\happy_var_1 -> return (FDef happy_var_1))) ns
semfn_16_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_var_4:happy_var_5:happy_rest) =  Branch (Sem_16 (\happy_var_1 -> \happy_var_2 -> \(TVar happy_var_4) -> \happy_var_5 -> return (Constant happy_var_1 happy_var_2 happy_var_4 happy_var_5))) ns
semfn_17_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_rest) =  Branch (Sem_17 (\happy_var_3 -> return (reverse happy_var_3))) ns
semfn_18_0 ns@(happy_rest) =  Branch (Sem_18 (return ([]))) ns
semfn_19_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_19 (\happy_var_1 -> \(TVar happy_var_2) -> return (happy_var_2 : happy_var_1))) ns
semfn_20_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_var_4:happy_var_5:happy_rest) =  Branch (Sem_20 (\happy_var_1 -> \happy_var_3 -> \happy_var_4 -> \happy_var_5 -> return (If happy_var_1 happy_var_3 happy_var_4 happy_var_5))) ns
semfn_21_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_21 (\happy_var_1 -> return (happy_var_1))) ns
semfn_22_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_22 (\happy_var_2 -> return (happy_var_2))) ns
semfn_23_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_rest) =  Branch (Sem_23 (\happy_var_1 -> \happy_var_2 -> \happy_var_3 -> return (Apply happy_var_1 happy_var_2 (reverse happy_var_3)))) ns
semfn_24_0 ns@(happy_rest) =  Branch (Sem_24 (return ([]))) ns
semfn_25_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_25 (\happy_var_1 -> \happy_var_2 -> return (happy_var_2 : happy_var_1))) ns
semfn_26_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_var_4:happy_rest) =  Branch (Sem_26 (\happy_var_1 -> \happy_var_2 -> \(TOp happy_var_3) -> \happy_var_4 -> return (Infix happy_var_1 happy_var_2 happy_var_3 happy_var_4))) ns
semfn_27_0 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_27 (\happy_var_1 -> \(TVar happy_var_2) -> return (OVar happy_var_1 happy_var_2))) ns
semfn_27_1 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_27 (\happy_var_1 -> \(TInt happy_var_2) -> return (OInt happy_var_1 happy_var_2))) ns
semfn_27_2 ns@(happy_var_1:happy_var_2:happy_rest) =  Branch (Sem_27 (\happy_var_1 -> \(TChar happy_var_2) -> return (OChar happy_var_1 happy_var_2))) ns
semfn_28_0 ns@(happy_var_1:happy_rest) =  Branch (Sem_28 (\happy_var_1 -> return (OBool happy_var_1 True))) ns
semfn_28_1 ns@(happy_var_1:happy_rest) =  Branch (Sem_28 (\happy_var_1 -> return (OBool happy_var_1 False))) ns
semfn_29_0 ns@(happy_var_1:happy_var_2:happy_var_3:happy_var_4:happy_rest) =  Branch (Sem_29 (\happy_var_1 -> \happy_var_3 -> \happy_var_4 -> return (Block happy_var_1 (reverse happy_var_3) happy_var_4))) ns


happy_join x = (>>=) x id
happy_ap f a = (>>=) f (\f -> (>>=) a (\a -> return(f a)))
type Decode_Result a = (OParser) a
happy_return = return :: a -> Decode_Result a
instance TreeDecode (CodeFragment) where 
	decode_b f (Branch (Sem_0 s) (_)) = map happy_join $ [return s]

instance TreeDecode (QType) where 
	decode_b f (Branch (Sem_1 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)
	decode_b f (Branch (Sem_2 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)

instance TreeDecode (Type) where 
	decode_b f (Branch (Sem_3 s) (b_0:b_1:_)) = map happy_join $ (cross_fn [return s] $ decode f b_1)
	decode_b f (Branch (Sem_4 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)
	decode_b f (Branch (Sem_5 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)

instance TreeDecode ([TypeName]) where 
	decode_b f (Branch (Sem_6 s) (b_0:b_1:b_2:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_2)
	decode_b f (Branch (Sem_7 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)

instance TreeDecode (TypeName) where 
	decode_b f (Branch (Sem_8 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)

instance TreeDecode (SimpleObelisk) where 
	decode_b f (Branch (Sem_9 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)

instance TreeDecode ([SimpleFDef]) where 
	decode_b f (Branch (Sem_10 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)
	decode_b f (Branch (Sem_11 s) (_)) = map happy_join $ [return s]

instance TreeDecode ([SimpleDef]) where 
	decode_b f (Branch (Sem_12 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)
	decode_b f (Branch (Sem_13 s) (_)) = map happy_join $ [return s]
	decode_b f (Branch (Sem_17 s) (b_0:b_1:b_2:_)) = map happy_join $ (cross_fn [return s] $ decode f b_2)

instance TreeDecode (SimpleFDef) where 
	decode_b f (Branch (Sem_14 s) (b_0:b_1:b_2:b_3:b_4:b_5:b_6:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1) $ decode f b_3) $ decode f b_4) $ decode f b_5) $ decode f b_6)

instance TreeDecode (SimpleDef) where 
	decode_b f (Branch (Sem_15 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)
	decode_b f (Branch (Sem_16 s) (b_0:b_1:b_2:b_3:b_4:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1) $ decode f b_3) $ decode f b_4)

instance TreeDecode ([String]) where 
	decode_b f (Branch (Sem_18 s) (_)) = map happy_join $ [return s]
	decode_b f (Branch (Sem_19 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)

instance TreeDecode (SimpleExp) where 
	decode_b f (Branch (Sem_20 s) (b_0:b_1:b_2:b_3:b_4:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_2) $ decode f b_3) $ decode f b_4)
	decode_b f (Branch (Sem_21 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)
	decode_b f (Branch (Sem_22 s) (b_0:b_1:_)) = map happy_join $ (cross_fn [return s] $ decode f b_1)
	decode_b f (Branch (Sem_23 s) (b_0:b_1:b_2:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1) $ decode f b_2)
	decode_b f (Branch (Sem_26 s) (b_0:b_1:b_2:b_3:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1) $ decode f b_2) $ decode f b_3)
	decode_b f (Branch (Sem_27 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)
	decode_b f (Branch (Sem_28 s) (b_0:_)) = map happy_join $ (cross_fn [return s] $ decode f b_0)

instance TreeDecode ([SimpleExp]) where 
	decode_b f (Branch (Sem_24 s) (_)) = map happy_join $ [return s]
	decode_b f (Branch (Sem_25 s) (b_0:b_1:_)) = map happy_join $ (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_1)

instance TreeDecode (SimpleBlock) where 
	decode_b f (Branch (Sem_29 s) (b_0:b_1:b_2:b_3:_)) = map happy_join $ (cross_fn (cross_fn (cross_fn [return s] $ decode f b_0) $ decode f b_2) $ decode f b_3)



type UserDefTok = Token
instance TreeDecode (Token) where
	decode_b f (Branch (SemTok t) []) = [happy_return t]
instance LabelDecode (Token) where
	unpack (SemTok t) = t


action 0 ( HappyTok (TParOpen) ) = Reduce [red_14]
action 0 ( HappyEOF ) = Reduce [red_14]
action 2 ( HappyEOF ) = Accept
action 3 ( HappyTok (TParOpen) ) = Reduce [red_1]
action 3 ( HappyEOF ) = Reduce [red_12]
action 4 ( HappyTok (TParOpen) ) = Reduce [red_1]
action 5 ( HappyTok (TParOpen) ) = Reduce [red_13]
action 5 ( HappyEOF ) = Reduce [red_13]
action 6 ( HappyTok (TParOpen) ) = Shift 10 []
action 7 ( HappyTok (TDef) ) = Shift 8 []
action 8 ( HappyTok (TVar _) ) = Shift 16 []
action 9 ( HappyTok (TTypeTerm) ) = Shift 15 []
action 10 ( HappyTok (TClassName _) ) = Shift 14 []
action 11 ( HappyTok (TParClose) ) = Shift 19 []
action 12 ( HappyTok (TArrow) ) = Shift 18 []
action 12 ( HappyTok (TParClose) ) = Reduce [red_8]
action 13 ( HappyTok (TArrow) ) = Reduce [red_10]
action 13 ( HappyTok (TParClose) ) = Reduce [red_10]
action 14 ( HappyTok (TArrow) ) = Reduce [red_11]
action 14 ( HappyTok (TTypeTerm) ) = Reduce [red_11]
action 14 ( HappyTok (TParClose) ) = Reduce [red_11]
action 15 ( HappyTok (TDef) ) = Reduce [red_4]
action 15 ( HappyTok (TConstant) ) = Reduce [red_4]
action 16 ( HappyTok (TVar _) ) = Reduce [red_22]
action 16 ( HappyTok (TBraceOpen) ) = Reduce [red_22]
action 17 ( HappyTok (TVar _) ) = Shift 23 []
action 17 ( HappyTok (TBraceOpen) ) = Reduce [red_1]
action 18 ( HappyTok (TClassName _) ) = Shift 14 []
action 19 ( HappyTok (TTypeTerm) ) = Reduce [red_6]
action 20 ( HappyTok (TArrow) ) = Reduce [red_9]
action 20 ( HappyTok (TParClose) ) = Reduce [red_9]
action 21 ( HappyTok (TBraceOpen) ) = Shift 26 []
action 22 ( HappyTok (TWhere) ) = Shift 25 []
action 22 ( HappyTok (TClassName _) ) = Reduce [red_21]
action 22 ( HappyTok (TParOpen) ) = Reduce [red_21]
action 22 ( HappyTok (TBraceClose) ) = Reduce [red_21]
action 22 ( HappyEOF ) = Reduce [red_21]
action 23 ( HappyTok (TVar _) ) = Reduce [red_23]
action 23 ( HappyTok (TBraceOpen) ) = Reduce [red_23]
action 24 ( HappyTok (TClassName _) ) = Reduce [red_17]
action 24 ( HappyTok (TParOpen) ) = Reduce [red_17]
action 24 ( HappyTok (TBraceClose) ) = Reduce [red_17]
action 24 ( HappyEOF ) = Reduce [red_17]
action 25 ( HappyTok (TBraceOpen) ) = Shift 28 []
action 26 ( HappyTok (TIf) ) = Reduce [red_35]
action 26 ( HappyTok (TInt _) ) = Reduce [red_35]
action 26 ( HappyTok (TVar _) ) = Reduce [red_35]
action 26 ( HappyTok (TTrue) ) = Reduce [red_35]
action 26 ( HappyTok (TFalse) ) = Reduce [red_35]
action 26 ( HappyTok (TWhere) ) = Reduce [red_35]
action 26 ( HappyTok (TBraceClose) ) = Reduce [red_35]
action 26 ( HappyTok (TChar _) ) = Reduce [red_35]
action 26 ( HappyTok (TPeriod) ) = Reduce [red_35]
action 27 ( HappyTok (TIf) ) = Reduce [red_1]
action 27 ( HappyTok (TInt _) ) = Reduce [red_1]
action 27 ( HappyTok (TVar _) ) = Reduce [red_1]
action 27 ( HappyTok (TTrue) ) = Reduce [red_1]
action 27 ( HappyTok (TFalse) ) = Reduce [red_1]
action 27 ( HappyTok (TWhere) ) = Shift 25 []
action 27 ( HappyTok (TBraceClose) ) = Reduce [red_21]
action 27 ( HappyTok (TChar _) ) = Reduce [red_1]
action 27 ( HappyTok (TPeriod) ) = Shift 39 []
action 28 ( HappyTok (TClassName _) ) = Reduce [red_16]
action 28 ( HappyTok (TParOpen) ) = Reduce [red_16]
action 28 ( HappyTok (TBraceClose) ) = Reduce [red_16]
action 29 ( HappyTok (TClassName _) ) = Reduce [red_1]
action 29 ( HappyTok (TParOpen) ) = Reduce [red_1]
action 29 ( HappyTok (TBraceClose) ) = Shift 54 []
action 30 ( HappyTok (TIf) ) = Shift 45 []
action 30 ( HappyTok (TInt _) ) = Shift 46 []
action 30 ( HappyTok (TVar _) ) = Shift 47 []
action 30 ( HappyTok (TTrue) ) = Shift 48 []
action 30 ( HappyTok (TFalse) ) = Shift 49 []
action 30 ( HappyTok (TChar _) ) = Shift 50 []
action 31 ( HappyTok (TBraceClose) ) = Shift 44 []
action 32 ( HappyTok (TIf) ) = Reduce [red_30]
action 32 ( HappyTok (TInt _) ) = Reduce [red_30]
action 32 ( HappyTok (TVar _) ) = Reduce [red_30]
action 32 ( HappyTok (TOp _) ) = Reduce [red_30]
action 32 ( HappyTok (TTrue) ) = Reduce [red_30]
action 32 ( HappyTok (TFalse) ) = Reduce [red_30]
action 32 ( HappyTok (TWhere) ) = Reduce [red_30]
action 32 ( HappyTok (TClassName _) ) = Reduce [red_30]
action 32 ( HappyTok (TParOpen) ) = Reduce [red_30]
action 32 ( HappyTok (TBraceOpen) ) = Reduce [red_30]
action 32 ( HappyTok (TBraceClose) ) = Reduce [red_30]
action 32 ( HappyTok (TChar _) ) = Reduce [red_30]
action 32 ( HappyTok (TPeriod) ) = Reduce [red_30]
action 33 ( HappyTok (TIf) ) = Reduce [red_29]
action 33 ( HappyTok (TInt _) ) = Reduce [red_29]
action 33 ( HappyTok (TVar _) ) = Reduce [red_29]
action 33 ( HappyTok (TOp _) ) = Reduce [red_29]
action 33 ( HappyTok (TTrue) ) = Reduce [red_29]
action 33 ( HappyTok (TFalse) ) = Reduce [red_29]
action 33 ( HappyTok (TWhere) ) = Reduce [red_29]
action 33 ( HappyTok (TClassName _) ) = Reduce [red_29]
action 33 ( HappyTok (TParOpen) ) = Reduce [red_29]
action 33 ( HappyTok (TBraceOpen) ) = Reduce [red_29]
action 33 ( HappyTok (TBraceClose) ) = Reduce [red_29]
action 33 ( HappyTok (TChar _) ) = Reduce [red_29]
action 33 ( HappyTok (TPeriod) ) = Reduce [red_29]
action 34 ( HappyTok (TIf) ) = Reduce [red_36]
action 34 ( HappyTok (TInt _) ) = Reduce [red_36]
action 34 ( HappyTok (TVar _) ) = Reduce [red_36]
action 34 ( HappyTok (TTrue) ) = Reduce [red_36]
action 34 ( HappyTok (TFalse) ) = Reduce [red_36]
action 34 ( HappyTok (TWhere) ) = Reduce [red_36]
action 34 ( HappyTok (TBraceClose) ) = Reduce [red_36]
action 34 ( HappyTok (TChar _) ) = Reduce [red_36]
action 34 ( HappyTok (TPeriod) ) = Reduce [red_36]
action 35 ( HappyTok (TIf) ) = Reduce [red_25]
action 35 ( HappyTok (TInt _) ) = Reduce [red_25]
action 35 ( HappyTok (TVar _) ) = Reduce [red_25]
action 35 ( HappyTok (TOp _) ) = Reduce [red_25]
action 35 ( HappyTok (TTrue) ) = Reduce [red_25]
action 35 ( HappyTok (TFalse) ) = Reduce [red_25]
action 35 ( HappyTok (TWhere) ) = Reduce [red_25]
action 35 ( HappyTok (TClassName _) ) = Reduce [red_25]
action 35 ( HappyTok (TParOpen) ) = Reduce [red_25]
action 35 ( HappyTok (TBraceOpen) ) = Reduce [red_25]
action 35 ( HappyTok (TBraceClose) ) = Reduce [red_25]
action 35 ( HappyTok (TChar _) ) = Reduce [red_25]
action 35 ( HappyTok (TPeriod) ) = Reduce [red_25]
action 36 ( HappyTok (TIf) ) = Reduce [red_26]
action 36 ( HappyTok (TInt _) ) = Reduce [red_26]
action 36 ( HappyTok (TVar _) ) = Reduce [red_26]
action 36 ( HappyTok (TOp _) ) = Reduce [red_26]
action 36 ( HappyTok (TTrue) ) = Reduce [red_26]
action 36 ( HappyTok (TFalse) ) = Reduce [red_26]
action 36 ( HappyTok (TWhere) ) = Reduce [red_26]
action 36 ( HappyTok (TClassName _) ) = Reduce [red_26]
action 36 ( HappyTok (TParOpen) ) = Reduce [red_26]
action 36 ( HappyTok (TBraceOpen) ) = Reduce [red_26]
action 36 ( HappyTok (TBraceClose) ) = Reduce [red_26]
action 36 ( HappyTok (TChar _) ) = Reduce [red_26]
action 36 ( HappyTok (TPeriod) ) = Reduce [red_26]
action 37 ( HappyTok (TIf) ) = Reduce [red_27]
action 37 ( HappyTok (TInt _) ) = Reduce [red_27]
action 37 ( HappyTok (TVar _) ) = Reduce [red_27]
action 37 ( HappyTok (TOp _) ) = Reduce [red_27]
action 37 ( HappyTok (TTrue) ) = Reduce [red_27]
action 37 ( HappyTok (TFalse) ) = Reduce [red_27]
action 37 ( HappyTok (TWhere) ) = Reduce [red_27]
action 37 ( HappyTok (TClassName _) ) = Reduce [red_27]
action 37 ( HappyTok (TParOpen) ) = Reduce [red_27]
action 37 ( HappyTok (TBraceOpen) ) = Reduce [red_27]
action 37 ( HappyTok (TBraceClose) ) = Reduce [red_27]
action 37 ( HappyTok (TChar _) ) = Reduce [red_27]
action 37 ( HappyTok (TPeriod) ) = Reduce [red_27]
action 38 ( HappyTok (TIf) ) = Reduce [red_28]
action 38 ( HappyTok (TInt _) ) = Reduce [red_28]
action 38 ( HappyTok (TVar _) ) = Reduce [red_28]
action 38 ( HappyTok (TOp _) ) = Reduce [red_28]
action 38 ( HappyTok (TTrue) ) = Reduce [red_28]
action 38 ( HappyTok (TFalse) ) = Reduce [red_28]
action 38 ( HappyTok (TWhere) ) = Reduce [red_28]
action 38 ( HappyTok (TClassName _) ) = Reduce [red_28]
action 38 ( HappyTok (TParOpen) ) = Reduce [red_28]
action 38 ( HappyTok (TBraceOpen) ) = Reduce [red_28]
action 38 ( HappyTok (TBraceClose) ) = Reduce [red_28]
action 38 ( HappyTok (TChar _) ) = Reduce [red_28]
action 38 ( HappyTok (TPeriod) ) = Reduce [red_28]
action 39 ( HappyTok (TIf) ) = Reduce [red_1]
action 39 ( HappyTok (TInt _) ) = Reduce [red_1]
action 39 ( HappyTok (TVar _) ) = Reduce [red_1]
action 39 ( HappyTok (TTrue) ) = Reduce [red_1]
action 39 ( HappyTok (TFalse) ) = Reduce [red_1]
action 39 ( HappyTok (TChar _) ) = Reduce [red_1]
action 39 ( HappyTok (TPeriod) ) = Reduce [red_1]
action 40 ( HappyTok (TIf) ) = Reduce [red_1]
action 40 ( HappyTok (TInt _) ) = Reduce [red_1]
action 40 ( HappyTok (TVar _) ) = Reduce [red_1]
action 40 ( HappyTok (TTrue) ) = Reduce [red_1]
action 40 ( HappyTok (TFalse) ) = Reduce [red_1]
action 40 ( HappyTok (TChar _) ) = Reduce [red_1]
action 40 ( HappyTok (TPeriod) ) = Shift 39 []
action 41 ( HappyTok (TPeriod) ) = Shift 60 []
action 42 ( HappyTok (TPeriod) ) = Reduce [red_32]
action 43 ( HappyTok (TPeriod) ) = Reduce [red_33]
action 44 ( HappyTok (TIf) ) = Reduce [red_43]
action 44 ( HappyTok (TInt _) ) = Reduce [red_43]
action 44 ( HappyTok (TVar _) ) = Reduce [red_43]
action 44 ( HappyTok (TOp _) ) = Reduce [red_43]
action 44 ( HappyTok (TTrue) ) = Reduce [red_43]
action 44 ( HappyTok (TFalse) ) = Reduce [red_43]
action 44 ( HappyTok (TWhere) ) = Reduce [red_43]
action 44 ( HappyTok (TClassName _) ) = Reduce [red_43]
action 44 ( HappyTok (TParOpen) ) = Reduce [red_43]
action 44 ( HappyTok (TBraceOpen) ) = Reduce [red_43]
action 44 ( HappyTok (TBraceClose) ) = Reduce [red_43]
action 44 ( HappyTok (TChar _) ) = Reduce [red_43]
action 44 ( HappyTok (TPeriod) ) = Reduce [red_43]
action 44 ( HappyEOF ) = Reduce [red_43]
action 45 ( HappyTok (TIf) ) = Reduce [red_1]
action 45 ( HappyTok (TInt _) ) = Reduce [red_1]
action 45 ( HappyTok (TVar _) ) = Reduce [red_1]
action 45 ( HappyTok (TTrue) ) = Reduce [red_1]
action 45 ( HappyTok (TFalse) ) = Reduce [red_1]
action 45 ( HappyTok (TChar _) ) = Reduce [red_1]
action 45 ( HappyTok (TPeriod) ) = Shift 39 []
action 46 ( HappyTok (TIf) ) = Reduce [red_39]
action 46 ( HappyTok (TInt _) ) = Reduce [red_39]
action 46 ( HappyTok (TVar _) ) = Reduce [red_39]
action 46 ( HappyTok (TOp _) ) = Reduce [red_39]
action 46 ( HappyTok (TTrue) ) = Reduce [red_39]
action 46 ( HappyTok (TFalse) ) = Reduce [red_39]
action 46 ( HappyTok (TWhere) ) = Reduce [red_39]
action 46 ( HappyTok (TClassName _) ) = Reduce [red_39]
action 46 ( HappyTok (TParOpen) ) = Reduce [red_39]
action 46 ( HappyTok (TBraceOpen) ) = Reduce [red_39]
action 46 ( HappyTok (TBraceClose) ) = Reduce [red_39]
action 46 ( HappyTok (TChar _) ) = Reduce [red_39]
action 46 ( HappyTok (TPeriod) ) = Reduce [red_39]
action 47 ( HappyTok (TIf) ) = Reduce [red_38]
action 47 ( HappyTok (TInt _) ) = Reduce [red_38]
action 47 ( HappyTok (TVar _) ) = Reduce [red_38]
action 47 ( HappyTok (TOp _) ) = Reduce [red_38]
action 47 ( HappyTok (TTrue) ) = Reduce [red_38]
action 47 ( HappyTok (TFalse) ) = Reduce [red_38]
action 47 ( HappyTok (TWhere) ) = Reduce [red_38]
action 47 ( HappyTok (TClassName _) ) = Reduce [red_38]
action 47 ( HappyTok (TParOpen) ) = Reduce [red_38]
action 47 ( HappyTok (TBraceOpen) ) = Reduce [red_38]
action 47 ( HappyTok (TBraceClose) ) = Reduce [red_38]
action 47 ( HappyTok (TChar _) ) = Reduce [red_38]
action 47 ( HappyTok (TPeriod) ) = Reduce [red_38]
action 48 ( HappyTok (TIf) ) = Reduce [red_40]
action 48 ( HappyTok (TInt _) ) = Reduce [red_40]
action 48 ( HappyTok (TVar _) ) = Reduce [red_40]
action 48 ( HappyTok (TOp _) ) = Reduce [red_40]
action 48 ( HappyTok (TTrue) ) = Reduce [red_40]
action 48 ( HappyTok (TFalse) ) = Reduce [red_40]
action 48 ( HappyTok (TWhere) ) = Reduce [red_40]
action 48 ( HappyTok (TClassName _) ) = Reduce [red_40]
action 48 ( HappyTok (TParOpen) ) = Reduce [red_40]
action 48 ( HappyTok (TBraceOpen) ) = Reduce [red_40]
action 48 ( HappyTok (TBraceClose) ) = Reduce [red_40]
action 48 ( HappyTok (TChar _) ) = Reduce [red_40]
action 48 ( HappyTok (TPeriod) ) = Reduce [red_40]
action 49 ( HappyTok (TIf) ) = Reduce [red_41]
action 49 ( HappyTok (TInt _) ) = Reduce [red_41]
action 49 ( HappyTok (TVar _) ) = Reduce [red_41]
action 49 ( HappyTok (TOp _) ) = Reduce [red_41]
action 49 ( HappyTok (TTrue) ) = Reduce [red_41]
action 49 ( HappyTok (TFalse) ) = Reduce [red_41]
action 49 ( HappyTok (TWhere) ) = Reduce [red_41]
action 49 ( HappyTok (TClassName _) ) = Reduce [red_41]
action 49 ( HappyTok (TParOpen) ) = Reduce [red_41]
action 49 ( HappyTok (TBraceOpen) ) = Reduce [red_41]
action 49 ( HappyTok (TBraceClose) ) = Reduce [red_41]
action 49 ( HappyTok (TChar _) ) = Reduce [red_41]
action 49 ( HappyTok (TPeriod) ) = Reduce [red_41]
action 50 ( HappyTok (TIf) ) = Reduce [red_42]
action 50 ( HappyTok (TInt _) ) = Reduce [red_42]
action 50 ( HappyTok (TVar _) ) = Reduce [red_42]
action 50 ( HappyTok (TOp _) ) = Reduce [red_42]
action 50 ( HappyTok (TTrue) ) = Reduce [red_42]
action 50 ( HappyTok (TFalse) ) = Reduce [red_42]
action 50 ( HappyTok (TWhere) ) = Reduce [red_42]
action 50 ( HappyTok (TClassName _) ) = Reduce [red_42]
action 50 ( HappyTok (TParOpen) ) = Reduce [red_42]
action 50 ( HappyTok (TBraceOpen) ) = Reduce [red_42]
action 50 ( HappyTok (TBraceClose) ) = Reduce [red_42]
action 50 ( HappyTok (TChar _) ) = Reduce [red_42]
action 50 ( HappyTok (TPeriod) ) = Reduce [red_42]
action 51 ( HappyTok (TClassName _) ) = Reduce [red_1]
action 51 ( HappyTok (TParOpen) ) = Reduce [red_1]
action 52 ( HappyTok (TClassName _) ) = Reduce [red_18]
action 52 ( HappyTok (TParOpen) ) = Reduce [red_18]
action 52 ( HappyTok (TBraceClose) ) = Reduce [red_18]
action 53 ( HappyTok (TClassName _) ) = Reduce [red_15]
action 53 ( HappyTok (TParOpen) ) = Reduce [red_15]
action 53 ( HappyTok (TBraceClose) ) = Reduce [red_15]
action 54 ( HappyTok (TClassName _) ) = Reduce [red_20]
action 54 ( HappyTok (TParOpen) ) = Reduce [red_20]
action 54 ( HappyTok (TBraceClose) ) = Reduce [red_20]
action 54 ( HappyEOF ) = Reduce [red_20]
action 55 ( HappyTok (TClassName _) ) = Shift 14 []
action 55 ( HappyTok (TParOpen) ) = Shift 10 []
action 56 ( HappyTok (TConstant) ) = Shift 65 []
action 57 ( HappyTok (TDef) ) = Shift 8 []
action 57 ( HappyTok (TConstant) ) = Reduce [red_2]
action 58 ( HappyTok (TConstant) ) = Reduce [red_3]
action 59 ( HappyTok (TBraceOpen) ) = Reduce [red_1]
action 60 ( HappyTok (TIf) ) = Reduce [red_31]
action 60 ( HappyTok (TInt _) ) = Reduce [red_31]
action 60 ( HappyTok (TVar _) ) = Reduce [red_31]
action 60 ( HappyTok (TOp _) ) = Reduce [red_31]
action 60 ( HappyTok (TTrue) ) = Reduce [red_31]
action 60 ( HappyTok (TFalse) ) = Reduce [red_31]
action 60 ( HappyTok (TWhere) ) = Reduce [red_31]
action 60 ( HappyTok (TClassName _) ) = Reduce [red_31]
action 60 ( HappyTok (TParOpen) ) = Reduce [red_31]
action 60 ( HappyTok (TBraceOpen) ) = Reduce [red_31]
action 60 ( HappyTok (TBraceClose) ) = Reduce [red_31]
action 60 ( HappyTok (TChar _) ) = Reduce [red_31]
action 60 ( HappyTok (TPeriod) ) = Reduce [red_31]
action 61 ( HappyTok (TIf) ) = Reduce [red_35]
action 61 ( HappyTok (TInt _) ) = Reduce [red_35]
action 61 ( HappyTok (TVar _) ) = Reduce [red_35]
action 61 ( HappyTok (TOp _) ) = Shift 63 []
action 61 ( HappyTok (TTrue) ) = Reduce [red_35]
action 61 ( HappyTok (TFalse) ) = Reduce [red_35]
action 61 ( HappyTok (TChar _) ) = Reduce [red_35]
action 61 ( HappyTok (TPeriod) ) = Reduce [red_35]
action 62 ( HappyTok (TIf) ) = Reduce [red_1]
action 62 ( HappyTok (TInt _) ) = Reduce [red_1]
action 62 ( HappyTok (TVar _) ) = Reduce [red_1]
action 62 ( HappyTok (TTrue) ) = Reduce [red_1]
action 62 ( HappyTok (TFalse) ) = Reduce [red_1]
action 62 ( HappyTok (TChar _) ) = Reduce [red_1]
action 62 ( HappyTok (TPeriod) ) = Shift 39 [red_34]
action 63 ( HappyTok (TIf) ) = Reduce [red_1]
action 63 ( HappyTok (TInt _) ) = Reduce [red_1]
action 63 ( HappyTok (TVar _) ) = Reduce [red_1]
action 63 ( HappyTok (TTrue) ) = Reduce [red_1]
action 63 ( HappyTok (TFalse) ) = Reduce [red_1]
action 63 ( HappyTok (TChar _) ) = Reduce [red_1]
action 63 ( HappyTok (TPeriod) ) = Shift 39 []
action 64 ( HappyTok (TBraceOpen) ) = Reduce [red_1]
action 65 ( HappyTok (TVar _) ) = Shift 69 []
action 66 ( HappyTok (TTypeTerm) ) = Shift 68 []
action 67 ( HappyTok (TTypeTerm) ) = Reduce [red_7]
action 68 ( HappyTok (TConstant) ) = Reduce [red_5]
action 69 ( HappyTok (TIf) ) = Reduce [red_1]
action 69 ( HappyTok (TInt _) ) = Reduce [red_1]
action 69 ( HappyTok (TVar _) ) = Reduce [red_1]
action 69 ( HappyTok (TTrue) ) = Reduce [red_1]
action 69 ( HappyTok (TFalse) ) = Reduce [red_1]
action 69 ( HappyTok (TChar _) ) = Reduce [red_1]
action 69 ( HappyTok (TPeriod) ) = Shift 39 []
action 70 ( HappyTok (TIf) ) = Reduce [red_24]
action 70 ( HappyTok (TInt _) ) = Reduce [red_24]
action 70 ( HappyTok (TVar _) ) = Reduce [red_24]
action 70 ( HappyTok (TOp _) ) = Reduce [red_24]
action 70 ( HappyTok (TTrue) ) = Reduce [red_24]
action 70 ( HappyTok (TFalse) ) = Reduce [red_24]
action 70 ( HappyTok (TWhere) ) = Reduce [red_24]
action 70 ( HappyTok (TClassName _) ) = Reduce [red_24]
action 70 ( HappyTok (TParOpen) ) = Reduce [red_24]
action 70 ( HappyTok (TBraceOpen) ) = Reduce [red_24]
action 70 ( HappyTok (TBraceClose) ) = Reduce [red_24]
action 70 ( HappyTok (TChar _) ) = Reduce [red_24]
action 70 ( HappyTok (TPeriod) ) = Reduce [red_24]
action 71 ( HappyTok (TPeriod) ) = Reduce [red_37]
action 72 ( HappyTok (TClassName _) ) = Reduce [red_19]
action 72 ( HappyTok (TParOpen) ) = Reduce [red_19]
action 72 ( HappyTok (TBraceClose) ) = Reduce [red_19]
action _ _ = Error
red_1 = (G_Pos,0 :: Int,semfn_0_0)
red_2 = (G_QType,1 :: Int,semfn_1_0)
red_3 = (G_QType,1 :: Int,semfn_1_0)
red_4 = (G_FQType,3 :: Int,semfn_2_0)
red_5 = (G_SQType,3 :: Int,semfn_2_0)
red_6 = (G_FType,3 :: Int,semfn_3_0)
red_7 = (G_SType,1 :: Int,semfn_4_0)
red_8 = (G_ArgTypes,1 :: Int,semfn_5_0)
red_9 = (G_TypeNames,3 :: Int,semfn_6_0)
red_10 = (G_TypeNames,1 :: Int,semfn_7_0)
red_11 = (G_TypeName,1 :: Int,semfn_8_0)
red_12 = (G_Obelisk,1 :: Int,semfn_9_0)
red_13 = (G_FDefs,2 :: Int,semfn_10_0)
red_14 = (G_FDefs,0 :: Int,semfn_11_0)
red_15 = (G_Defs,2 :: Int,semfn_12_0)
red_16 = (G_Defs,0 :: Int,semfn_13_0)
red_17 = (G_FDef,7 :: Int,semfn_14_0)
red_18 = (G_Def,1 :: Int,semfn_15_0)
red_19 = (G_Def,5 :: Int,semfn_16_0)
red_20 = (G_WhereClause,4 :: Int,semfn_17_0)
red_21 = (G_WhereClause,0 :: Int,semfn_13_0)
red_22 = (G_Vars,0 :: Int,semfn_18_0)
red_23 = (G_Vars,2 :: Int,semfn_19_0)
red_24 = (G_If,5 :: Int,semfn_20_0)
red_25 = (G_TExp,1 :: Int,semfn_21_0)
red_26 = (G_TExp,1 :: Int,semfn_21_0)
red_27 = (G_TExp,1 :: Int,semfn_21_0)
red_28 = (G_TExp,1 :: Int,semfn_21_0)
red_29 = (G_Exp,1 :: Int,semfn_21_0)
red_30 = (G_Exp,1 :: Int,semfn_21_0)
red_31 = (G_Exp,3 :: Int,semfn_22_0)
red_32 = (G_PExp,1 :: Int,semfn_21_0)
red_33 = (G_PExp,1 :: Int,semfn_21_0)
red_34 = (G_Apply,3 :: Int,semfn_23_0)
red_35 = (G_Exps,0 :: Int,semfn_24_0)
red_36 = (G_Exps,2 :: Int,semfn_25_0)
red_37 = (G_Infix,4 :: Int,semfn_26_0)
red_38 = (G_Var,2 :: Int,semfn_27_0)
red_39 = (G_Int,2 :: Int,semfn_27_1)
red_40 = (G_Bool,2 :: Int,semfn_28_0)
red_41 = (G_Bool,2 :: Int,semfn_28_1)
red_42 = (G_Char,2 :: Int,semfn_27_2)
red_43 = (G_Block,5 :: Int,semfn_29_0)
goto 0 G_Obelisk = 2
goto 0 G_FDefs = 3

goto 3 G_Pos = 4
goto 3 G_FDef = 5

goto 4 G_Pos = 6
goto 4 G_FQType = 7

goto 6 G_FType = 9

goto 10 G_ArgTypes = 11
goto 10 G_TypeNames = 12
goto 10 G_TypeName = 13

goto 16 G_Vars = 17

goto 17 G_Pos = 21
goto 17 G_Block = 22

goto 18 G_TypeName = 20

goto 22 G_WhereClause = 24

goto 26 G_Exps = 27

goto 27 G_Pos = 30
goto 27 G_WhereClause = 31
goto 27 G_If = 32
goto 27 G_TExp = 33
goto 27 G_Exp = 34
goto 27 G_Var = 35
goto 27 G_Int = 36
goto 27 G_Bool = 37
goto 27 G_Char = 38

goto 28 G_Defs = 29

goto 29 G_Pos = 51
goto 29 G_FDef = 52
goto 29 G_Def = 53

goto 39 G_Pos = 40
goto 39 G_PExp = 41
goto 39 G_Apply = 42
goto 39 G_Infix = 43

goto 40 G_Pos = 30
goto 40 G_If = 32
goto 40 G_TExp = 33
goto 40 G_Exp = 61
goto 40 G_Var = 35
goto 40 G_Int = 36
goto 40 G_Bool = 37
goto 40 G_Char = 38

goto 45 G_Pos = 30
goto 45 G_If = 32
goto 45 G_TExp = 33
goto 45 G_Exp = 59
goto 45 G_Var = 35
goto 45 G_Int = 36
goto 45 G_Bool = 37
goto 45 G_Char = 38

goto 51 G_Pos = 55
goto 51 G_QType = 56
goto 51 G_FQType = 57
goto 51 G_SQType = 58

goto 55 G_FType = 9
goto 55 G_SType = 66
goto 55 G_TypeName = 67

goto 59 G_Pos = 21
goto 59 G_Block = 64

goto 61 G_Exps = 62

goto 62 G_Pos = 30
goto 62 G_If = 32
goto 62 G_TExp = 33
goto 62 G_Exp = 34
goto 62 G_Var = 35
goto 62 G_Int = 36
goto 62 G_Bool = 37
goto 62 G_Char = 38

goto 63 G_Pos = 30
goto 63 G_If = 32
goto 63 G_TExp = 33
goto 63 G_Exp = 71
goto 63 G_Var = 35
goto 63 G_Int = 36
goto 63 G_Bool = 37
goto 63 G_Char = 38

goto 64 G_Pos = 21
goto 64 G_Block = 70

goto 69 G_Pos = 30
goto 69 G_If = 32
goto 69 G_TExp = 33
goto 69 G_Exp = 72
goto 69 G_Var = 35
goto 69 G_Int = 36
goto 69 G_Bool = 37
goto 69 G_Char = 38

goto _ _ = -1
