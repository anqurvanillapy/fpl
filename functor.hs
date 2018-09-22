{--
 -  Functor
 -  =======
 -
 -  Functor instance examples.
 -}

-- | Maybe with counting.

data CntMaybe a
  = CntJust Integer a
  | CntNothing
  deriving Show

instance Functor CntMaybe where
  fmap f CntNothing = CntNothing
  fmap f (CntJust n a) = CntJust (n + 1) (f a)

-- | A bit more complicated example.

newtype Foo a = Foo { foo :: Integer -> (a, Integer) }

instance Functor Foo where
  fmap f (Foo a) = Foo $ \n -> (f . fst $ a n, n + 1)

main :: IO ()
main = do
  print $ (++ "!") <$> CntNothing
  print $ (++ "!") <$> CntJust 0 "Hello, world"
