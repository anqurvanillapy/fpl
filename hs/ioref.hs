{--
 -  IORef
 -  =====
 -
 -  Bring the imperative smells, bring it.
 -}

import Control.Monad
import Data.IORef

count :: Eq a => [a] -> a -> IO Int
count xs x = do
  r <- newIORef 0
  forM_ xs $ \y ->
    when (x == y) $
      modifyIORef r (+1)
  readIORef r

main :: IO ()
main = print =<< count [1, 1, 2, 3, 5, 8] 1
-- 2
