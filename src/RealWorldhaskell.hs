module RealWorldhaskell where

import System.Directory
import System.FilePath
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer

data AppConfig = AppConfig {
      cfgMaxDepth :: Int
    } deriving (Show)

data AppState = AppState {
      stDeepestReached :: Int
    } deriving (Show)
data AppLog = AppLog {
      filePath :: FilePath
      ,count :: Int
   } deriving (Show)

newtype App = WriterT [AppLog] ( ReaderT AppConfig (StateT AppState IO))

runApp :: App a -> Int -> IO ((a, [AppLog]), AppState)
runApp k maxDepth =
    let config = AppConfig maxDepth
        state = AppState 0
    in runStateT (runReaderT (runWriter k ) config) state

constrainedCount :: Int -> FilePath -> App ()
constrainedCount curDepth path = do
    contents <- liftIO . listDirectory $ path
    cfg <- ask
    rest <- forM contents $ \name -> do
            let newPath = path </> name
            isDir <- liftIO $ doesDirectoryExist newPath
            if isDir && curDepth < cfgMaxDepth cfg
                then do
                let newDepth = curDepth + 1
                st <- get
                when (stDeepestReached st < newDepth) $
                    put st { stDeepestReached = newDepth }
                constrainedCount newDepth newPath
                else return []
    return $ (path, length contents) : concat rest