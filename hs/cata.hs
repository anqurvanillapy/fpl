{--
 -  Catamorphism
 -  ============
 -
 -  It can map from an initial algebra to some other algebra.
 -}

type StepAlgebra b = (b, b -> b)

data Nat = Zero | Succ Nat

-- | Algebra Nat mapped to algebra b.
foldSteps :: StepAlgebra b -> Nat -> b
foldSteps (nil, next) Zero          = nil
foldSteps (nil, next) (Succ nat)    = next $ foldSteps (nil, next) nat

main :: IO ()
main = putStr $ foldSteps (">", ("=" ++)) (Succ . Succ . Succ $ Zero)
