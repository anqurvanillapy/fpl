{--
 -  Applicative do-notation
 -  =======================
 -
 -  Language `ApplicativeDo` transforms this
 -
 -    (\x y z -> x*y + y*z + z*x) <$> expr1 <*> expr2 <*> expr3
 -
 -  ...into this
 -
 -    do x <- expr1; y <- expr2; z <- expr3; return (x*y + y*z + z*x)
 -
 -  Since do-notation is more natural.  And it also enables possible concurrency
 -  optimizations like what Haxl does.
 -}

{-# LANGUAGE ApplicativeDo #-}

-- | Bad example here, actually.
main :: IO ()
main = do
  { x <- getLine
  ; y <- getLine
  ; return $ x ++ y } >>= putStrLn
