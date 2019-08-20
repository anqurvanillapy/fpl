{-# OPTIONS --cubical --safe #-}

-- | Quotient integer
module QuoInt where

open import Cubical.Core.Everything
open import Cubical.HITs.Ints.QuoInt renaming (_+ℤ_ to _+_; ℤ to Z)

open import Cubical.Data.Nat hiding (_+_)
open import Cubical.Foundations.Prelude

+-i-zero : ∀ a i → posneg i + a ≡ a
+-i-zero a i =
  cong (_+ a) (lemma₁ i)
  ∙ -- x ≡ y → y ≡ z → x ≡ z
  lemma₀ a
  where
    lemma₀ : ∀ a → pos 0 + a ≡ a
    lemma₀ (pos zero) = refl
    lemma₀ (pos (suc n)) = cong sucℤ (lemma₀ (pos n))
    lemma₀ (neg zero) = posneg
    lemma₀ (neg (suc n)) = cong predℤ (lemma₀ (neg n))
    lemma₀ (posneg i) j = posneg (i ∧ j)

    lemma₁ : ∀ i → posneg i ≡ pos 0
    lemma₁ i j = posneg (i ∧ ~ j)
