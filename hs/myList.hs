data List a
  = Nil
  | Cons a (List a)

myHead :: List a -> a
myHead (Cons x xs) = x
myHead Nil = error "head: empty list"

myTail :: List a -> List a
myTail (Cons x xs) = xs
myTail Nil = error "tail: empty list"

myLast :: List a -> a
myLast (Cons x Nil) = x
myLast (Cons x xs) = myLast xs
myLast Nil = error "last: empty list"

e :: List Int
e = Nil

l :: List Int
l = Cons 42 (Cons 69 Nil)

main :: IO ()
main = do
  print . myHead $ l
  print . myHead . myTail $ l
  print . myLast $ l
  print . myHead $ e
