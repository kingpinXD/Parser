module Readfile where

import           System.Environment
import           Control.Concurrent
import           Control.Exception
import           System.Timeout

catchAny :: IO a -> (SomeException -> IO a) -> IO a
catchAny = Control.Exception.catch


readFromDisk :: FilePath -> IO String
readFromDisk  f =  do 
    file <- readFile f 
    return file


getContents :: IO ()
getContents = do
  filecontent <- readFromDisk "./asd.txt"
  print filecontent
  return ()
