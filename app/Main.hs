module Main where

import           Ex
import           Lib
import           Word
import           Readfile
--import           Rm

main :: IO ()
--main = (print . parse . tokenize) "x1 = -15 / (2 + x2)"
main = print $ sentence "Ceci n'est pas une phrase"
