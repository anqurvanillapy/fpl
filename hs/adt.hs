-- | Haskell's data types can be simultaneously positive and negative.
data P a
  = Cons a -- a constructor
  | Getter (P a -> a) -- an eliminator

p :: P Int
p = Cons 42

getter :: P Int
getter = Getter fn
  where
    fn (Cons n) = n

elim :: P Int -> P Int -> IO ()
elim p (Getter f) = print $ f p

main :: IO ()
main = elim p getter
