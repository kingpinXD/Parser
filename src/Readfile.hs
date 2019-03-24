module Readfile where

import           System.Environment
import           Control.Concurrent
import           Control.Exception.Safe as R
import           System.Timeout




readFromDisk :: FilePath -> IO String
readFromDisk  f =  do
    file <- readFile f
    return file

getContents :: IO ()
getContents = do
  x <-
    R.catchAny (readFromDisk "./asd.txt") $ \e -> do
      putStrLn $ "Caught an exception: " ++ show e
      return ""
  putStrLn $ x

