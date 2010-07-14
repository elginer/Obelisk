-- | Perform lexical analysis on Obelisk source
module Language.Obelisk.Lexer where

import Language.Obelisk.Parser.Monad

import Language.Obelisk.Lexer.Token

import Text.Parsec.Token as T
import Text.Parsec.Language
import Text.Parsec.String
import Text.Parsec

import Data.Either

-- | Obelisk language definition 
obdef :: LanguageDef st
obdef = LanguageDef 
   {commentStart   = "/*"
   ,commentEnd     = "*/"
   ,commentLine    = "//"
   ,nestedComments = False
   ,identStart     = letter <|> char '_'
   ,identLetter    = alphaNum <|> char '_'
   ,opStart        = oneOf ":!#$%&*+./<=>?@\\^|-~"
   ,opLetter       = oneOf ":!#$%&*+./<=>?@\\^|-~"
   ,reservedNames  = ["def", "true", "false"]
   ,reservedOpNames = ["="]
   ,caseSensitive   = True}

-- | Obelisk token parser
obtok :: TokenParser st
obtok =
   makeTokenParser obdef 

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

-- | Take obelisk source and return a list of tokens or an error.
ob_lex :: FilePath -> String -> Either ParseError [Token]
ob_lex = parse plex
   where
   plex = do
      ts <- many $ T.whiteSpace obtok >> tlex
      T.whiteSpace obtok
      eof
      return $ ts ++ [TEOF]

-- | Lexical analyzer for parsers generated by Happy
lex :: (Token -> Parse) -> Parse
lex cont = OParser $ \i s ->
   if null i
      then continue TEOF i s
      else either (ParseFail . show) 
                  (\(t, p, r) -> continue t r p)
                  (parse (ilex s) "" i)
   where
   continue t r p =
      let OParser crf = cont t
      in  crf r p
   ilex s = do
      setPosition s
      t <- tlex
      s <- getPosition
      i <- getInput
      return $ (t, s, i)

-- | Parse a token with parsec
tlex :: Parser Token
tlex =
   fmap TInt (T.decimal obtok)
   <|> (T.reserved obtok "true" >> return TTrue)
   <|> (T.reserved obtok "false" >> return TFalse)
   <|> (T.reserved obtok "def" >> return TDef)
   <|> (T.reserved obtok "if" >> return TIf)
   <|> (T.reservedOp obtok "=" >> return LocalSetter)
   <|> par_open
   <|> par_close
   <|> fmap TVar (T.identifier obtok)
   <|> fmap TOp (T.operator obtok)

      
