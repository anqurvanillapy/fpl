{- Product type in System F -}

{-# LANGUAGE RankNTypes #-}

type MyPair = forall t . (Int -> Bool -> t) -> t

myPair :: Int -> Bool -> MyPair
-- Ayy yo pointfrrrrreee
myPair = flip . flip id
-- myPair x y f = f x y

proj1 :: MyPair -> Int
proj1 p = p (\x y -> x)

proj2 :: MyPair -> Bool
proj2 p = p (\x y -> y)

main :: IO ()
main = do
  print (proj1 (myPair 42 True))
  print (proj2 (myPair 42 True))
