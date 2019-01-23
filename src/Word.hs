module Word
  ( sentence
  ) where

import           Data.Char

type W = String

sentence :: String -> [W]
sentence "" = [""]
sentence str =
  let (w, restofstring) = word str
   in w : sentence restofstring

-- returns a word and the rest of input
word :: String -> (W, String)
word "" = ("", "")
word (c:cs)
  | isSpace c = ("", cs)
  | otherwise =
    let (w, cs') = word cs
     in (c : w, cs')
