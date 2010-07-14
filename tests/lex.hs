-- Ensure that Obelisk source is lexed properly
import Language.Obelisk.Lexer
import Language.Obelisk.Lexer.Token

main =
   mapM lex_test tests

lex_test = 
   either print print . ob_lex "test data"

tests =
   ["(def nice"
   ,")))"
   ,"123"
   ,"1 2 3"
   ,"//howdy\n(def (c) (x c))"
   ,"/* all is well */ + 1"]
