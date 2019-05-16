{-
 -  Applicative
 -  ===========
 -
 -  Applicative instance examples.
 -}

import Control.Applicative

newtype Foo a = Foo { foo :: Int -> (a, Int) }

instance Functor Foo where
    fmap f (Foo a) = Foo $ \n -> (f . fst . a $ n, n + 1)

instance Applicative Foo where
    pure a = Foo $ \n -> (a, n + 1)
    (Foo a) <*> (Foo b) = Foo $ \n -> ((fst . a $ n) (fst . b $ n), n + 1)

main :: IO ()
main = print 42
