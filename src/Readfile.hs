{-# LANGUAGE ExistentialQuantification #-}

module Readfile where

import           Control.Concurrent
import           Control.Exception.Safe as R
import           System.Timeout


instance Exception SubExceptions where
  toException = toException . OtherExceptions . SomeException
  fromException se = do
    OtherExceptions (SomeException e) <- fromException se
    cast e

readFromDisk :: FilePath -> IO String
readFromDisk f = do
  file <- readFile f
  return file

getContent :: IO ()
getContent = do
  x <-
    R.catchAny (readFromDisk "./asd.txt") $ \e -> do
      putStrLn $ "Caught an exception: " ++ show e
      return ""
  putStrLn $ x

throwErrorSample :: IO ()
throwErrorSample = do
  e <- try $ throwIO $ NetworkFailure "Certificate not received"
  print (e :: Either SomeException ())
