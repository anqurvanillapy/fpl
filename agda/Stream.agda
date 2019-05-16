data _≡_ {ℓ} {A : Set ℓ} (x : A) : A → Set ℓ where
  refl : x ≡ x

data ℕ : Set where
  zero : ℕ
  succ : ℕ → ℕ

record Stream (A : Set) : Set where
  constructor stream
  field
    start : A
    next : A → A

open Stream

ℕ-stream : Stream ℕ
start ℕ-stream = zero
next ℕ-stream n = succ n

0th : {A : Set} → Stream A → A
0th s = start s

3rd : {A : Set} → Stream A → A
3rd s = next s (next s (next s (start s)))

_ : 0th ℕ-stream ≡ zero
_ = refl

_ : 3rd ℕ-stream ≡ succ (succ (succ zero))
_ = refl
