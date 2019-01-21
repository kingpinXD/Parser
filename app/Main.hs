module Main where

import           Lib

main :: IO ()
main = print $ tokenize "12 + 24 / x1"
