{-# OPTIONS --safe #-}

module Invert where

open import Relation.Binary.PropositionalEquality
open import Data.Nat

open import Data.Nat.Properties

_∘_ : ∀ {A B C : Set} → (B → C) → (A → B) → (A → C)
(g ∘ f) x = g (f x)

pred₂ : ℕ → ℕ
pred₂ = pred ∘ pred

lemma : (a b : ℕ) → pred₂ (suc a + suc a) ≡ pred₂ (suc b + suc b)
        → a + a ≡ b + b
lemma a b p =
  begin
  a + a ≡⟨⟩
  pred₂ (suc (suc (a + a))) ≡⟨⟩
  pred₂ (suc (suc a + a)) ≡⟨ cong (pred₂ ∘ suc) (+-comm (suc a) a)  ⟩
  pred₂ (suc (a + suc a)) ≡⟨⟩
  pred₂ (suc a + suc a) ≡⟨ p ⟩
  pred₂ (suc b + suc b) ≡⟨⟩
  pred₂ (suc (b + suc b)) ≡⟨ cong (pred₂ ∘ suc) (+-comm b (suc b)) ⟩
  pred₂ (suc (suc b + b)) ≡⟨⟩
  b + b
  ∎ where open ≡-Reasoning

invert : (a b : ℕ) → a + a ≡ b + b → a ≡ b
invert zero zero p = refl
invert (suc m) (suc n) p = cong suc (invert m n (lemma m n (cong pred₂ p)))
