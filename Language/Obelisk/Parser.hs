{-# OPTIONS_GHC -fno-warn-overlapping-patterns #-}
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

-- parser produced by Happy Version 1.18.5

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (CodeFragment)
	| HappyAbsSyn5 (QType)
	| HappyAbsSyn8 (Type)
	| HappyAbsSyn11 ([TypeName])
	| HappyAbsSyn12 (TypeName)
	| HappyAbsSyn13 (SimpleObelisk)
	| HappyAbsSyn14 ([SimpleFDef])
	| HappyAbsSyn15 ([SimpleDef])
	| HappyAbsSyn16 (SimpleFDef)
	| HappyAbsSyn17 (SimpleDef)
	| HappyAbsSyn19 ([String])
	| HappyAbsSyn20 (SimpleExp)
	| HappyAbsSyn25 ([SimpleExp])
	| HappyAbsSyn31 (SimpleBlock)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70 :: () => Int -> ({-HappyReduction (OParser) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (OParser) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (OParser) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (OParser) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43 :: () => ({-HappyReduction (OParser) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> (OParser) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> (OParser) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> (OParser) HappyAbsSyn)

action_0 (13) = happyGoto action_2
action_0 (14) = happyGoto action_3
action_0 _ = happyReduce_14

action_1 _ = happyFail

action_2 (48) = happyAccept
action_2 _ = happyFail

action_3 (48) = happyReduce_12
action_3 (4) = happyGoto action_4
action_3 (16) = happyGoto action_5
action_3 _ = happyReduce_1

action_4 (4) = happyGoto action_6
action_4 (6) = happyGoto action_7
action_4 _ = happyReduce_1

action_5 _ = happyReduce_13

action_6 (43) = happyShift action_10
action_6 (8) = happyGoto action_9
action_6 _ = happyFail

action_7 (32) = happyShift action_8
action_7 _ = happyFail

action_8 (35) = happyShift action_15
action_8 _ = happyFail

action_9 _ = happyReduce_4

action_10 (41) = happyShift action_14
action_10 (10) = happyGoto action_11
action_10 (11) = happyGoto action_12
action_10 (12) = happyGoto action_13
action_10 _ = happyFail

action_11 (44) = happyShift action_18
action_11 _ = happyFail

action_12 (42) = happyShift action_17
action_12 _ = happyReduce_8

action_13 _ = happyReduce_10

action_14 _ = happyReduce_11

action_15 (19) = happyGoto action_16
action_15 _ = happyReduce_22

action_16 (35) = happyShift action_22
action_16 (4) = happyGoto action_20
action_16 (31) = happyGoto action_21
action_16 _ = happyReduce_1

action_17 (41) = happyShift action_14
action_17 (12) = happyGoto action_19
action_17 _ = happyFail

action_18 _ = happyReduce_6

action_19 _ = happyReduce_9

action_20 (45) = happyShift action_25
action_20 _ = happyFail

action_21 (39) = happyShift action_24
action_21 (18) = happyGoto action_23
action_21 _ = happyReduce_21

action_22 _ = happyReduce_23

action_23 _ = happyReduce_17

action_24 (45) = happyShift action_27
action_24 _ = happyFail

action_25 (25) = happyGoto action_26
action_25 _ = happyReduce_35

action_26 (39) = happyShift action_24
action_26 (43) = happyShift action_38
action_26 (46) = happyReduce_21
action_26 (4) = happyGoto action_29
action_26 (18) = happyGoto action_30
action_26 (20) = happyGoto action_31
action_26 (21) = happyGoto action_32
action_26 (22) = happyGoto action_33
action_26 (27) = happyGoto action_34
action_26 (28) = happyGoto action_35
action_26 (29) = happyGoto action_36
action_26 (30) = happyGoto action_37
action_26 _ = happyReduce_1

action_27 (15) = happyGoto action_28
action_27 _ = happyReduce_16

action_28 (46) = happyShift action_53
action_28 (4) = happyGoto action_50
action_28 (16) = happyGoto action_51
action_28 (17) = happyGoto action_52
action_28 _ = happyReduce_1

action_29 (33) = happyShift action_44
action_29 (34) = happyShift action_45
action_29 (35) = happyShift action_46
action_29 (37) = happyShift action_47
action_29 (38) = happyShift action_48
action_29 (47) = happyShift action_49
action_29 _ = happyFail

action_30 (46) = happyShift action_43
action_30 _ = happyFail

action_31 _ = happyReduce_30

action_32 _ = happyReduce_29

action_33 _ = happyReduce_36

action_34 _ = happyReduce_25

action_35 _ = happyReduce_26

action_36 _ = happyReduce_27

action_37 _ = happyReduce_28

action_38 (4) = happyGoto action_39
action_38 (23) = happyGoto action_40
action_38 (24) = happyGoto action_41
action_38 (26) = happyGoto action_42
action_38 _ = happyReduce_1

action_39 (43) = happyShift action_38
action_39 (4) = happyGoto action_29
action_39 (20) = happyGoto action_31
action_39 (21) = happyGoto action_32
action_39 (22) = happyGoto action_60
action_39 (27) = happyGoto action_34
action_39 (28) = happyGoto action_35
action_39 (29) = happyGoto action_36
action_39 (30) = happyGoto action_37
action_39 _ = happyReduce_1

action_40 (44) = happyShift action_59
action_40 _ = happyFail

action_41 _ = happyReduce_32

action_42 _ = happyReduce_33

action_43 _ = happyReduce_43

action_44 (43) = happyShift action_38
action_44 (4) = happyGoto action_29
action_44 (20) = happyGoto action_31
action_44 (21) = happyGoto action_32
action_44 (22) = happyGoto action_58
action_44 (27) = happyGoto action_34
action_44 (28) = happyGoto action_35
action_44 (29) = happyGoto action_36
action_44 (30) = happyGoto action_37
action_44 _ = happyReduce_1

action_45 _ = happyReduce_39

action_46 _ = happyReduce_38

action_47 _ = happyReduce_40

action_48 _ = happyReduce_41

action_49 _ = happyReduce_42

action_50 (4) = happyGoto action_54
action_50 (5) = happyGoto action_55
action_50 (6) = happyGoto action_56
action_50 (7) = happyGoto action_57
action_50 _ = happyReduce_1

action_51 _ = happyReduce_18

action_52 _ = happyReduce_15

action_53 _ = happyReduce_20

action_54 (41) = happyShift action_14
action_54 (43) = happyShift action_10
action_54 (8) = happyGoto action_9
action_54 (9) = happyGoto action_65
action_54 (12) = happyGoto action_66
action_54 _ = happyFail

action_55 (40) = happyShift action_64
action_55 _ = happyFail

action_56 (32) = happyShift action_8
action_56 _ = happyReduce_2

action_57 _ = happyReduce_3

action_58 (4) = happyGoto action_20
action_58 (31) = happyGoto action_63
action_58 _ = happyReduce_1

action_59 _ = happyReduce_31

action_60 (36) = happyShift action_62
action_60 (25) = happyGoto action_61
action_60 _ = happyReduce_35

action_61 (43) = happyShift action_38
action_61 (44) = happyReduce_34
action_61 (4) = happyGoto action_29
action_61 (20) = happyGoto action_31
action_61 (21) = happyGoto action_32
action_61 (22) = happyGoto action_33
action_61 (27) = happyGoto action_34
action_61 (28) = happyGoto action_35
action_61 (29) = happyGoto action_36
action_61 (30) = happyGoto action_37
action_61 _ = happyReduce_1

action_62 (43) = happyShift action_38
action_62 (4) = happyGoto action_29
action_62 (20) = happyGoto action_31
action_62 (21) = happyGoto action_32
action_62 (22) = happyGoto action_69
action_62 (27) = happyGoto action_34
action_62 (28) = happyGoto action_35
action_62 (29) = happyGoto action_36
action_62 (30) = happyGoto action_37
action_62 _ = happyReduce_1

action_63 (4) = happyGoto action_20
action_63 (31) = happyGoto action_68
action_63 _ = happyReduce_1

action_64 (35) = happyShift action_67
action_64 _ = happyFail

action_65 _ = happyReduce_5

action_66 _ = happyReduce_7

action_67 (43) = happyShift action_38
action_67 (4) = happyGoto action_29
action_67 (20) = happyGoto action_31
action_67 (21) = happyGoto action_32
action_67 (22) = happyGoto action_70
action_67 (27) = happyGoto action_34
action_67 (28) = happyGoto action_35
action_67 (29) = happyGoto action_36
action_67 (30) = happyGoto action_37
action_67 _ = happyReduce_1

action_68 _ = happyReduce_24

action_69 _ = happyReduce_37

action_70 _ = happyReduce_19

happyReduce_1 = happyMonadReduce 0 4 happyReduction_1
happyReduction_1 (happyRest) tk
	 = happyThen (( get_pos)
	) (\r -> happyReturn (HappyAbsSyn4 r))

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  6 happyReduction_4
happyReduction_4 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (QType happy_var_1 [] happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_2  7 happyReduction_5
happyReduction_5 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn5
		 (QType happy_var_1 [] happy_var_2
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  8 happyReduction_6
happyReduction_6 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  9 happyReduction_7
happyReduction_7 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn8
		 (Type happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  10 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn8
		 (Function $ reverse happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  11 happyReduction_9
happyReduction_9 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_3 : happy_var_1
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  11 happyReduction_10
happyReduction_10 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  12 happyReduction_11
happyReduction_11 (HappyTerminal (TClassName happy_var_1))
	 =  HappyAbsSyn12
		 (TypeClassName happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  13 happyReduction_12
happyReduction_12 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (Obelisk $ reverse happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_2  14 happyReduction_13
happyReduction_13 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_2 : happy_var_1
	)
happyReduction_13 _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  14 happyReduction_14
happyReduction_14  =  HappyAbsSyn14
		 ([]
	)

happyReduce_15 = happySpecReduce_2  15 happyReduction_15
happyReduction_15 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_2 : happy_var_1
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_0  15 happyReduction_16
happyReduction_16  =  HappyAbsSyn15
		 ([]
	)

happyReduce_17 = happyReduce 7 16 happyReduction_17
happyReduction_17 ((HappyAbsSyn15  happy_var_7) `HappyStk`
	(HappyAbsSyn31  happy_var_6) `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	(HappyTerminal (TVar happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Def happy_var_1 happy_var_2 happy_var_4 happy_var_5 happy_var_6 happy_var_7
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_1  17 happyReduction_18
happyReduction_18 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (FDef happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happyReduce 5 17 happyReduction_19
happyReduction_19 ((HappyAbsSyn20  happy_var_5) `HappyStk`
	(HappyTerminal (TVar happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (Constant happy_var_1 happy_var_2 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 18 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (reverse happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_0  18 happyReduction_21
happyReduction_21  =  HappyAbsSyn15
		 ([]
	)

happyReduce_22 = happySpecReduce_0  19 happyReduction_22
happyReduction_22  =  HappyAbsSyn19
		 ([]
	)

happyReduce_23 = happySpecReduce_2  19 happyReduction_23
happyReduction_23 (HappyTerminal (TVar happy_var_2))
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_2 : happy_var_1
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happyReduce 5 20 happyReduction_24
happyReduction_24 ((HappyAbsSyn31  happy_var_5) `HappyStk`
	(HappyAbsSyn31  happy_var_4) `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (If happy_var_1 happy_var_3 happy_var_4 happy_var_5
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_1  21 happyReduction_25
happyReduction_25 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  21 happyReduction_26
happyReduction_26 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  21 happyReduction_27
happyReduction_27 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  21 happyReduction_28
happyReduction_28 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  22 happyReduction_29
happyReduction_29 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  22 happyReduction_30
happyReduction_30 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  22 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  23 happyReduction_32
happyReduction_32 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  23 happyReduction_33
happyReduction_33 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  24 happyReduction_34
happyReduction_34 (HappyAbsSyn25  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (Apply happy_var_1 happy_var_2 (reverse happy_var_3)
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_0  25 happyReduction_35
happyReduction_35  =  HappyAbsSyn25
		 ([]
	)

happyReduce_36 = happySpecReduce_2  25 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_2 : happy_var_1
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happyReduce 4 26 happyReduction_37
happyReduction_37 ((HappyAbsSyn20  happy_var_4) `HappyStk`
	(HappyTerminal (TOp happy_var_3)) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Infix happy_var_1 happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_2  27 happyReduction_38
happyReduction_38 (HappyTerminal (TVar happy_var_2))
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (OVar happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  28 happyReduction_39
happyReduction_39 (HappyTerminal (TInt happy_var_2))
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (OInt happy_var_1 happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  29 happyReduction_40
happyReduction_40 _
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (OBool happy_var_1 True
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  29 happyReduction_41
happyReduction_41 _
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (OBool happy_var_1 False
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  30 happyReduction_42
happyReduction_42 (HappyTerminal (TChar happy_var_2))
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (OChar happy_var_1 happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happyReduce 5 31 happyReduction_43
happyReduction_43 (_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn31
		 (Block happy_var_1 (reverse happy_var_3) happy_var_4
	) `HappyStk` happyRest

happyNewToken action sts stk
	= lex(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	TEOF -> action 48 48 tk (HappyState action) sts stk;
	TDef -> cont 32;
	TIf -> cont 33;
	TInt happy_dollar_dollar -> cont 34;
	TVar happy_dollar_dollar -> cont 35;
	TOp happy_dollar_dollar -> cont 36;
	TTrue -> cont 37;
	TFalse -> cont 38;
	TWhere -> cont 39;
	TConstant -> cont 40;
	TClassName happy_dollar_dollar -> cont 41;
	TArrow -> cont 42;
	TParOpen -> cont 43;
	TParClose -> cont 44;
	TBraceOpen -> cont 45;
	TBraceClose -> cont 46;
	TChar happy_dollar_dollar -> cont 47;
	_ -> happyError' tk
	})

happyError_ tk = happyError' tk

happyThen :: () => OParser a -> (a -> OParser b) -> OParser b
happyThen = (>>=)
happyReturn :: () => a -> OParser a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> OParser a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> OParser a
happyError' tk = terror tk

parse = happySomeParser where
  happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn13 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq



{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}








{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 148 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let (i) = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@(((st1@(HappyState (action))):(_)))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 246 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 310 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
