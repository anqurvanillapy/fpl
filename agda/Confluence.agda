{-# OPTIONS --safe #-}

module Confluence where

open import Relation.Binary.PropositionalEquality
  using (_≡_; refl)

cong : ∀ {A B : Set} {x y : A} (f : A → B) → x ≡ y → f x ≡ f y
cong f refl = refl

data ℕ : Set where
  Z : ℕ
  S : ℕ → ℕ

add : ℕ → ℕ → ℕ
add n Z = n
add n (S m) = S (add n m)

_ : ∀ {a : ℕ} → add a Z ≡ a
_ = refl

thm : ∀ {a : ℕ} → add Z a ≡ a
thm {a = Z} = refl
thm {a = (S m)} = cong S thm
