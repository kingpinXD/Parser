{-# LANGUAGE ExistentialQuantification #-}

module Readfile where

import           Control.Concurrent
import           System.Environment

--import           Control.Exception
import           Control.Exception.Safe
import           Data.Typeable
import           System.Timeout

data CAClientExceptions
  = InvalidInput String
  | FileReadingException String
  | OtherExceptions SomeException
  deriving (Show, Typeable)

instance Exception CAClientExceptions

data SubExceptions =
  NetworkFailure String
  deriving (Show, Typeable)

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
    catch (readFromDisk "./asd.txt") $ \e -- why doesnt catchanywork
     -> do
      putStrLn $ "Caught an exception: "
      Left e <- try $ throwIO $ FileReadingException "File not found"
      return e
  putStrLn $ x ----- Replace with bracket ?

throwErrorSample :: IO ()
throwErrorSample = do
  e <- try $ throwIO $ NetworkFailure "Certificate not received"
  print (e :: Either SomeException ())
