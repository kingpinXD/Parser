module Test where

import           Control.Exception
import           Control.Monad.Error
import           Control.Monad.Reader
import           Data.ConfigFile
import           System.IO

data ConfigInfo = ConfigInfo
  { path     :: String
  , fileName :: String
  } deriving (Show)

-- readConfig :: MonadIO m => String -> m ConfigInfo
-- readConfig f = do
--   rv <-
--     runErrorT $
--       -- open the configuration file
--      do
--       cp <- join $ liftIO $ readfile emptyCP f
--       let x = cp
--       -- read out the attributes
--       pv <- get x "DEFAULT" "path"
--       fv <- get x "DEFAULT" "filename"
--       -- build the config value
--       return (ConfigInfo {path = pv, fileName = fv})
--   either (\x -> error (snd x)) (\x -> return x) rv

readConfig :: MonadIO m => String -> m ConfigInfo
readConfig f = do

     bracket (readfile emptyCP f) hClose 
      (\h -> undefined)
    


--getConfig :: ReaderT ConfigInfo IO ConfigInfo
getConfig = do
  config <- readConfig "D:\\Parser\\src\\config.cfg"
  --return config
  putStrLn $ "The path value is: " ++ (path config)
  putStrLn $ "The filename value is: " ++ (fileName config) -- getPath :: ReaderT ConfigInfo IO String
-- getPath = do
--   env <- ask
--   liftIO $ putStrLn (path env)
--   return (path env)
-- useconfig :: IO ConfigInfo
-- useconfig = runReaderT getConfig (ConfigInfo "tmp" "asd")
-- usepath :: IO String
-- usepath = runReaderT getPath (ConfigInfo "tmp" "asd")
-- tomAndJerry :: Reader String String
-- tomAndJerry = do
--   t <- tom
--   j <- jerry
--   return (t ++ "\n" ++ j)
-- runJerryRun :: String
-- runJerryRun = (runReader tomAndJerry) "Who is this?"
