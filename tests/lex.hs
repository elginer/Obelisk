-- Ensure that Obelisk source is lexed properly!
import Language.Obelisk.Lexer
import Language.Obelisk.Lexer.Token

-- Examine the output.  Make sure it is 'okay'.  
main =
   mapM lex_test tests

lex_test = 
   either print print . ob_lex "test data"

tests =
   ["(def nice"
   ,"))) where"
   ,"123"
   ,"1 2 3"
   ,"//howdy\n(def (c) (x c))"
   ,"/* all is well */ + 1"
   ,": : : : 222"]
