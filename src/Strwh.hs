module Strwh where

import           Control.Exception
import           Control.Monad.Reader
import           Control.Monad.State
import           System.IO
import qualified System.Random        as R


next :: Supply s (Maybe s)
next = undefined

runSupply :: Supply s a -> [s] -> (a, [s])
runSupply = undefined

data CountedRandom = CountedRandom
  { crGen   :: R.StdGen
  , crCount :: Int
  }

type RandomState a = State R.StdGen a
newtype Supply s a =
  S (State [s] a)

type CRState a = State CountedRandom a

getRandom :: R.Random a => RandomState a
getRandom = do
  gen <- get
  let (val, gen') = R.random gen
  put gen'
  return val

getTwoRandoms :: R.Random a => RandomState (a, a)
getTwoRandoms = liftM2 (,) getRandom getRandom

runTwoRandoms :: IO (Int, Int)
runTwoRandoms = do
  oldState <- R.getStdGen
  let (result, newState) = runState getTwoRandoms oldState
  R.setStdGen newState
  return result

getCountedRandom :: R.Random a => CRState a
getCountedRandom = do
  st <- get
  let (val, gen') = R.random (crGen st)
  put CountedRandom {crGen = gen', crCount = crCount st + 1}
  return val

getCount :: CRState Int
getCount = crCount `liftM` get

putCount :: Int -> CRState ()
putCount a = do
  st <- get
  put st {crCount = a}
