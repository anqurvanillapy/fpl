import Prelude hiding ((.))

-- | Dot selection
(.) :: a -> (a -> b) -> b
a . b = b a

main :: IO ()
main = 42.show.putStrLn
