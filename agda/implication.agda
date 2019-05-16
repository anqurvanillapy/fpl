data ⊥ : Set where

p0 : Set → Set
p0 A = A

p1 : ⊥ → Set
p1 ()

p2 : ⊥ → ⊥
p2 ()

p3 : Set → ⊥
p3 = ?
