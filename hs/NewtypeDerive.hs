{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module NewtypeDerive where

newtype Context a = Context { getContext :: [a] }
  deriving (Functor, Show)

empty :: Context a
empty = Context []

insert :: a -> Context a -> Context a
insert n (Context ls) = Context (n : ls)

main :: IO ()
main = print $ fmap (+1) (insert 2 (insert 1 empty))
