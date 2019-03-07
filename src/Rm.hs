module Rm where

-- import           Control.Monad.Error
-- import           Control.Monad.Reader
-- import           Data.ConfigFile

-- data ConfigInfo = ConfigInfo
--   { path     :: String
--   , fileName :: String
--   }

-- readConfig :: String -> IO ConfigInfo
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
--    -- in the instance that configuration reading failed we'll
--    -- fail the application here, otherwise send out the config
--    -- value that we've built
--   either (\x -> error (snd x)) (\x -> return x) rv

-- --getConfig :: IO ()
-- getConfig = do
--   config <- readConfig "D:\\Haskell\\Parser\\src\\config.cfg"
--   let str = runReader func1 config
--   --y <- lift $ config
--   --putStrLn $ "The path value is: " ++ (path config)
--   --putStrLn $ "The filename value is: " ++ (fileName config)
--   print str

-- -- newtype CA a = CA
-- --   { _readerT :: ReaderT Caconfig IO a
-- --   } deriving (Functor, Applicative, Monad, MonadIO, MonadReader Caconfig)
-- -- runCa :: Caconfig -> Ca a -> IO a
-- -- runCa CAconfig (Ca m) = runReaderT m CAconfig
-- -- mkCaConfig :: Caconfig
-- -- mkCaConfig = initConfig ["tmp"]
-- -- initConfig :: [String] -> HadoopConfig
-- -- initConfig listofconfigValues = Caconfig {path = listofconfigValues ! 1}
-- -- createPath :: ReaderT Path IO Path
-- -- createPath =
-- --   return (Path "tmp" 1)
-- -- usePath :: ReaderT Path IO Path
-- -- usePath = do
-- --   env <- ask
-- --   putStrLn env
-- func1 = do
--   env <- ask
--   return path env
