module Main where

import           Lib

main :: IO ()
main = (print . parse . tokenize) "x1 = -15 / (2 + x2)"
