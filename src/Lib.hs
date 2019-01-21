module Lib
  ( someFunc
  ) where

data Token
  = TokOp Operator
  | TokIdent String
  | TokNum Int
  deriving (Show, Eq)

data Operator
  = Plus
  | Minus
  | Times
  | Div

opToChar :: Operator -> Char
opToChar Plus  = '+'
opToChar Minus = '-'
opToChar Times = '*'
opToChar Div   = '/'

tokenise :: String -> Token
tokenise (c:cs) =
  let c = isAlpha c
   in if isAlpha
        then identify (c : cs)
        else tokenise cs

identify :: String -> (String, String)
identify (c:cs) =
  let (identifier, restofstring) = alnums cs
   in TokIdent identifier : tokenise restofstring

alnums :: String -> (String,String)
alnums