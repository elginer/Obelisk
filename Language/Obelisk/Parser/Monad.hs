-- | A parser monad
module Language.Obelisk.Parser.Monad where

import Text.Parsec.Pos

import Language.Obelisk.AST.Simple

import Language.Obelisk.Error

-- | Our overall parser type
type Parse = OParser SimpleObelisk

-- | The parser can succeed or fail with a message
data ParseResult a =
   ParseOK a
   | ParseFail String
   deriving Show

-- | The parser monad passes the input string and source location around, and deals with errors.
newtype OParser a = OParser (String -> CodeFragment -> ParseResult a)

-- | Run a parser
run_parser :: Parse    -- ^ The parser
           -> FilePath -- ^ The source name
           -> String   -- ^ The input
           -> SimpleObelisk
run_parser par fp i = do
   case eparse par fp i of
      ParseOK ob -> ob
      ParseFail s -> error s

-- | Execute a parser
eparse :: Parse -- ^ The parser
       -> FilePath -- ^ The source name
       -> String -- ^ The input
       -> ParseResult SimpleObelisk
eparse (OParser par) fp i =
   par i $ CodeFragment (newPos fp 1 1) ""

instance Monad OParser where
   return a = 
      OParser $ const $ const $ ParseOK a

   (OParser fa) >>= amb = 
      OParser $ \i sp -> 
         case fa i sp of
            ParseOK a ->
               let OParser fb = amb a
               in  fb i sp
            ParseFail err -> ParseFail err

   fail err = OParser $ \_ fr ->
      ParseFail $ pretty $ error_line "Parse error" $ error_section $ fragment_error fr
-- | Get the current source code position and code fragment
get_pos :: OParser CodeFragment
get_pos = OParser $ const ParseOK
