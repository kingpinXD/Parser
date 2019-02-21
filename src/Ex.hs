module Ex
  ( parse2
  ) where

import           Data.Char

parse2 :: String -> Int
parse2 str = calvalue 0 str
  where
    calvalue val [] = val
    calvalue val (c:cs)
      | isDigit c = calvalue (val + digitToInt c) cs
      | otherwise = calvalue val cs
