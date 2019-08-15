f0 :: a -> (a -> b) -> b
f0 = flip id

f1 :: a -> b -> (a -> b -> c) -> c
f1 = flip . flip id

main :: IO ()
main = do
  putStrLn $ f0 "Hello, " (++ "world!")
  putStrLn $ f1 "Hello, " "world!" (++)
