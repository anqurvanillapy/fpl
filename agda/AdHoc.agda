{-# OPTIONS --safe #-}

{- Ad-hoc polymorphism -}
module AdHoc where

open import Data.Char as C
open import Data.String as S
open import Data.List as L
open import Data.Integer as I
open import Data.Nat as N
open import Data.Bool as B

open import Agda.Builtin.Nat renaming (_==_ to natEquals)

record Eq {l} (A : Set l) : Set l where
  field
    _===_ : A → A → Bool

open Eq ⦃ ... ⦄ public

_=/=_ : ∀ {l} {A : Set l} ⦃ _ : Eq A ⦄ → A → A → Bool
a =/= b = not (a === b)

instance
  eqInt : Eq ℤ
  _===_ ⦃ eqInt ⦄ (+ m) (+ n) = natEquals m n
  _===_ ⦃ eqInt ⦄ (-[1+ m ]) (-[1+ n ]) = natEquals m n
  _===_ ⦃ eqInt ⦄ _ _ = false

  eqNat : Eq ℕ
  _===_ ⦃ eqNat ⦄ = natEquals

  eqChar : Eq Char
  _===_ ⦃ eqChar ⦄ = C._==_

  eqBool : Eq Bool
  _===_ ⦃ eqBool ⦄ a b = not (a xor b)
  
  eqStr : Eq String
  _===_ ⦃ eqStr ⦄ = S._==_

  eqList : ∀ {l} {A : Set l} ⦃ _ : Eq A ⦄ → Eq (List A)
  _===_ ⦃ eqList ⦄ [] [] = true
  _===_ ⦃ eqList ⦄ (x ∷ xs) (y ∷ ys) = (x === y) ∧ (xs === ys)
  _===_ ⦃ eqList ⦄ _ _ = false
