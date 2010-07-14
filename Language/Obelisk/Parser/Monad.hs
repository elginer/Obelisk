-- | A parser monad
module Language.Obelisk.Parser.Monad where

import Text.Parsec.Pos

import Language.Obelisk.AST.Simple

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
           -> IO SimpleObelisk
run_parser (OParser par) fp i = do
   putStrLn $ "Parsing " ++ fp ++ "..."
   case par i $ CodeFragment (newPos fp 1 1) "" of
      ParseOK ob -> return ob
      ParseFail s -> error s

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
      ParseFail $ unlines $
         "\n\tParse error: " : map ("\t\t" ++) (lines err ++ lines (pretty fr))

-- | Get the current source code position and code fragment
get_pos :: OParser CodeFragment
get_pos = OParser $ const ParseOK
