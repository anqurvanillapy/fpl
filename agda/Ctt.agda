{-# OPTIONS --cubical --safe #-}

module Ctt where

open import Cubical.Core.Everything

-- Identity function.
id : ∀ {ℓ} {A : Set ℓ} (x : A) → A
id x = x

-- Funciton composition.
_∘_ : ∀ {ℓ} {A B C : Set ℓ} (g : B → C) (f : A → B) → A → C
g ∘ f = λ a → g (f a)

-- Equivalence is the path to `x` itself.
refl : ∀ {ℓ} {A : Set ℓ} {x : A} → Path A x x
refl {x = x} = λ i → x

-- A square in `A` is built out of 4 points and 4 lines.
square : ∀ {ℓ} {A : Set ℓ} {x0 x1 y0 y1 : A}
  → x0 ≡ x1 → y0 ≡ y1 → x0 ≡ y0 → x1 ≡ y1
  → Set ℓ
square p q r s = PathP (λ i → p i ≡ q i) r s

-- Symmetry.
sym : ∀ {ℓ} {A : Set ℓ} {x y : A} → x ≡ y → y ≡ x
sym p i = p (~ i)
-- sym p i = λ i → p (~ i)

-- Congruence.
cong : ∀ {ℓ} {A : Set ℓ} {x y : A} {B : A → Set ℓ}
  (f : (a : A) → B a) (p : x ≡ y)
  → PathP (λ i → B (p i)) (f x) (f y)
cong f p i = f (p i)

-- Symmetry inverse.
symInv : ∀ {ℓ} {A : Set ℓ} {x y : A} (p : x ≡ y) → sym (sym p) ≡ p
symInv p = refl

-- Congruence with identity function.
congId : ∀ {ℓ} {A : Set ℓ} {x y : A} (p : x ≡ y) → cong id p ≡ p
congId p = refl

-- Congruence with composition.
congComp : ∀ {ℓ} {A B C : Set ℓ}
  (f : A → B) (g : B → C)
  {x y : A} (p : x ≡ y)
  → cong (g ∘ f) p ≡ cong g (cong f p)
congComp f g p = refl

-- Function extensionality.
funExt : ∀ {ℓ} {A : Set ℓ} {B : A → Set ℓ} {f g : (x : A) → B x}
  → ((x : A) → f x ≡ g x) → f ≡ g
funExt p i x = p x i
-- `p` matches the 1st parameter,
-- `i` matches the dimension of the 1st parameter,
-- `i` matches `(x : A)`,
-- `funExt p i x = {!!}` the goal matches `B x`,
-- `(p x) i` is obvious.
