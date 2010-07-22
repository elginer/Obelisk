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

-- | Perform lexical analysis on Obelisk source
module Language.Obelisk.Lexer where

import Language.Obelisk.AST.Simple

import Language.Obelisk.Parser.Monad

import Language.Obelisk.Lexer.Token

import Language.Obelisk.Error

import Text.Parsec.Token as T
import Text.Parsec.Language
import Text.Parsec.String
import Text.Parsec

import Data.Either

import Data.Char

import Debug.Trace

-- | Make parsec errors into a compiler error
instance ErrorReport ParseError where
   report e = error_lines (lines (show e)) empty_error

-- | Obelisk language definition 
obdef :: LanguageDef st
obdef = LanguageDef 
   {commentStart   = "/*"
   ,commentEnd     = "*/"
   ,commentLine    = "//"
   ,nestedComments = False
   ,identStart     = lower
   ,identLetter    = alphaNum <|> oneOf "_?"
   ,opStart        = oneOf ":!#$%&*+./<=>@\\^|-~"
   ,opLetter       = oneOf ":!#$%&*+./<=>@\\^|-~"
   ,reservedNames  = ["def", "if", "true", "false", "where", "let"]
   ,reservedOpNames = ["->", "#"]
   ,caseSensitive   = True}

-- | Obelisk token parser
obtok :: TokenParser st
obtok =
   makeTokenParser obdef 

-- | Parse a class name
class_name :: Parser Token
class_name = do
   fst <- upper
   rst <- many alphaNum
   return $ TClassName $ fst : rst

-- | Parse the open parenthesis
par_open :: Parser Token
par_open = do
   char '('
   return TParOpen

-- | Parse the close parenthesis
par_close :: Parser Token
par_close = do
   char ')'
   return TParClose

chomp :: String -> String
chomp = reverse . chomp_front . reverse . chomp_front 
   where
   chomp_front = dropWhile isSpace

-- | Take obelisk source and return a list of tokens or an error.
ob_lex :: FilePath -> String -> Either ParseError [Token]
ob_lex fp str = parse plex fp $ chomp str
   where
   plex = do
      ts <- many $ T.whiteSpace obtok >> tlex
      T.whiteSpace obtok
      eof
      return $ ts ++ [TEOF]

-- | There was a lexical error
lexical_error :: CodeFragment -> String -> String
lexical_error fr s = '\n' : show fr ++ "\n\tThere was a lexical error near: " ++ show s

-- | Lexical analyzer for parsers generated by Happy
lex :: (Token -> OParser a) -> OParser a
lex cont = OParser $ \i report ->
   either (\err ->
      either (const $ ParseFail $ lexical_error report $ takeWhile (not . isSpace) $ dropWhile isSpace i) 
             (const $ continue TEOF i report)
             (parse (T.whiteSpace obtok >> eof) "" i))
          (\(t, f, r) -> continue t r f)
          (parse (ilex $ pos report) "" i)
   where
   continue t r p =
      let OParser crf = cont t
      in  crf r p
   ilex s = do
      setPosition s
      T.whiteSpace obtok
      cod <- fmap (unlines . take 1 . lines) getInput
      t <- tlex
      p <- getPosition
      i <- getInput
      return $ (t, CodeFragment p cod, i)

-- | Parse a token with parsec
tlex :: Parser Token
tlex =
   fmap TInt (T.decimal obtok)
   <|> (T.reserved obtok "true" >> return TTrue)
   <|> (T.reserved obtok "false" >> return TFalse)
   <|> (T.reserved obtok "def" >> return TDef)
   <|> (T.reserved obtok "if" >> return TIf)
   <|> (T.reserved obtok "where" >> return TWhere)
   <|> (T.reserved obtok "let" >> return TConstant)
   <|> (T.reservedOp obtok "->" >> return TArrow)
   <|> (T.reservedOp obtok "#" >> return TTypeTerm)
   <|> class_name 
   <|> par_open
   <|> par_close
   <|> fmap TVar (T.identifier obtok)
   <|> fmap TOp (T.operator obtok)
   <|> fmap TChar (T.charLiteral obtok)

      
