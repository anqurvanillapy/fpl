import Prelude hiding ((.))
import Data.Function hiding ((.))

-- | Dot selection, or reverse application operator
(.) :: a -> (a -> b) -> b
a . b = b a

main :: IO ()
main = do
  42.show.putStrLn
  42&show&putStrLn -- in Data.Function
