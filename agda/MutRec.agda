-- Mutual Recursion.

module MutRec where

open import Relation.Binary.PropositionalEquality using (_≡_; refl)

data Odd : Set

data Even : Set where
  e0 : Even
  eS : Odd → Even

data Odd where
  oS : Even → Odd

addEO : Even → Odd → Odd

addOO : Odd → Odd → Even
addOO (oS m) n = eS (addEO m n)

addEO e0 n = n
addEO (eS m) n = oS (addOO m n)

_ : addEO (eS (oS e0)) (oS e0) ≡ oS (eS (oS e0))
_ = refl
