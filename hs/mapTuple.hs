{-
 -  mapTuple
 -  ========
 -
 -  `map' function but maps on tuple.
 -}

import Control.Monad (join)
import Control.Arrow

mapTuple :: Arrow a => a b c -> a (b, b) (c, c)
mapTuple = join (***)

main :: IO ()
main = print $ mapTuple (+ 1) (1, 2)
