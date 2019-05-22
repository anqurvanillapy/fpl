{-
 - Prelude: Play with some basic theorems...
 -}

{-# OPTIONS --rewriting #-}

module Prelude where

open import Agda.Builtin.Equality public
open import Agda.Builtin.Nat renaming (Nat to ℕ) public

{-# BUILTIN REWRITE _≡_ #-}

-- Identity function
id : ∀ {ℓ} {A : Set ℓ} → A → A
id x = x

_ : id 42 ≡ 42
_ = refl

-- Composition
_∘_ :
  ∀ {ℓ m n}
  {A : Set ℓ}
  {B : Set m}
  {C : B → Set n}
  (g : (b : B) → C b)
  (f : A → B)
  → ---------
  (a : A) → C (f a)
(g ∘ f) x = g (f x)

_ : (id ∘ id) 42 ≡ id (id 42)
_ = refl

-- Transitivity
trans :
  ∀ {ℓ}
  {A : Set ℓ}
  {x y z : A}
  (q : y ≡ z)
  (p : x ≡ y)
  → ---------
  x ≡ z
trans n refl = n

-- Symmetry
symm :
  ∀ {ℓ}
  {A : Set ℓ}
  {x y : A}
  (p : x ≡ y)
  → ---------
  y ≡ x
symm refl = refl

-- Congruence
cong :
  ∀ {ℓ ℓ′}
  {A : Set ℓ}
  {B : Set ℓ′}
  (f : A → B)
  {x y : A}
  (p : x ≡ y)
  → ---------
  f x ≡ f y
cong _ refl = refl

cong₂ :
  ∀ {ℓ ℓ′}
  {A A′ : Set ℓ}
  {B : Set ℓ′}
  (f : A → A′ → B)
  {x y : A}
  {x′ y′ : A′}
  (p : x ≡ y)
  (q : x′ ≡ y′)
  → -----------
  f x x′ ≡ f y y′
cong₂ _ refl refl = refl

-- Substitution
subst :
  ∀ {ℓ ℓ′}
  {A : Set ℓ}
  (B : A → Set ℓ′)
  {x y : A}
  (p : x ≡ y)
  → ---------
  B x → B y
subst _ refl = λ a → a

-- Type coercion
coe :
  ∀ {ℓ}
  {A B : Set ℓ}
  → -----------
  A ≡ B → A → B
coe r a = subst id r a
