{- Sum type in System F -}

{-# LANGUAGE RankNTypes #-}

type MyEither = forall t . (Int -> t) -> (Bool -> t) -> t

myLeft :: Int -> MyEither
myLeft x f _ = f x

myRight :: Bool -> MyEither
myRight x _ g = g x

myEither :: forall t . (Int -> t) -> (Bool -> t) -> MyEither -> t
-- Let's get pointfrrrrreeee!
myEither = flip . flip id
-- myEither f g e = e f g

main :: IO ()
main = do
  myEither (print) (print) (myLeft 42)
  myEither (print) (print) (myRight True)
