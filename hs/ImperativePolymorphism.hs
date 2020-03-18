{-# LANGUAGE RankNTypes #-}

foo :: (forall a . a -> a) -> Int
foo _ = 42

bar :: forall b . Bool -> b -> b
bar _ = id

ok :: Bool -> Int
ok x = foo (bar x)

bad :: Bool -> Int
bad = foo . bar -- the errors look crazy here

-- We have to instantiate a polymorphic type variable `q` with a polymorphic
-- type `forall a . a -> a`, so `bad` is rejected by the type checker.  This
-- is called *imperative polymorphism*.
