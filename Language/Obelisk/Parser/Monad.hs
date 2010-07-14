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
newtype OParser a = OParser (String -> SourcePos -> ParseResult a)

-- | Run a parser
run_parser :: Parse    -- ^ The parser
           -> FilePath -- ^ The source name
           -> String   -- ^ The input
           -> IO SimpleObelisk
run_parser (OParser par) fp i = do
   putStrLn $ "Parsing " ++ fp ++ "..."
   case par i $ newPos fp 1 1 of
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

   fail err = OParser $ const $ const $ ParseFail err 

-- | A parse error
parse_error :: String -> OParser a
parse_error err = OParser $ \_ sp ->
   ParseFail $ unlines $ 
      ["Parse error at: " ++ show sp] ++ map ('\t' :) (lines err)

-- | Get the current source code position
get_pos :: OParser SourcePos
get_pos = OParser $ const ParseOK
