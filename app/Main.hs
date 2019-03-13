module Main where

import           Ex
import           Lib
import           Word
import Strwh
--import           Rm
import Test

main :: IO ()
--main = (print . parse . tokenize) "x1 = -15 / (2 + x2)"
main = print $ sentence "Ceci n'est pas une phrase"
