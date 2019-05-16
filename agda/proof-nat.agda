import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎)

data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

{-# BUILTIN NATURAL ℕ #-}

{- Addition -}

_+_ : ℕ → ℕ → ℕ
zero    + n =  n
(suc m) + n =  suc (m + n)

_ : 3 + 4 ≡ 7
_ =
  begin
    3 + 4
  ≡⟨⟩
    suc (2 + 4)
  ≡⟨⟩
    suc (suc (1 + 4))
  ≡⟨⟩
    suc (suc (suc (0 + 4)))
  ≡⟨⟩
    suc (suc (suc 4))
  ≡⟨⟩
    7
  ∎

_ : 1 + 1 ≡ 2
_ = refl

{- Multiplication -}

_*_ : ℕ → ℕ → ℕ
zero * n    = zero
(suc m) * n = n + (m * n)

_ : 2 * 2 ≡ 4
_ =
  begin
    2 * 2
  ≡⟨⟩
    2 + (1 * 2)
  ≡⟨⟩
    2 + (2 + (0 * 2))
  ≡⟨⟩
    2 + 2
  ≡⟨⟩
    4
  ∎

_ : 1 * 1 ≡ 1
_ = refl

{- Exponentiation -}

_^_ : ℕ → ℕ → ℕ
n ^ 0       = 1
n ^ (suc m) = n * (n ^ m)

_ : 2 ^ 3 ≡ 8
_ =
  begin
    2 ^ 3
  ≡⟨⟩
    2 * (2 ^ 2)
  ≡⟨⟩
    2 * (2 * (2 ^ 1))
  ≡⟨⟩
    2 * (2 * (2 * (2 ^ 0)))
  ≡⟨⟩
    2 * (2 * (2 * 1))
  ≡⟨⟩
    8
  ∎

_ : 42 ^ 0 ≡ 1
_ = refl

{- Monus -}

_∸_ : ℕ → ℕ → ℕ
m       ∸ zero    = m
zero    ∸ (suc n) = zero
(suc m) ∸ (suc n) = m ∸ n

_ : 2 ∸ 1 ≡ 1
_ =
  begin
    2 ∸ 1
  ≡⟨⟩
    1 ∸ 0
  ≡⟨⟩
    1
  ∎

_ : 7 ∸ 4 ≡ 3
_ = refl

_ : 4 ∸ 7 ≡ 0
_ = refl
