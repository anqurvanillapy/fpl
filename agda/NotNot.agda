module NotNot where

data ⊥ : Set where

Not : Set → Set
Not A = ⊥

Whoa : ∀ {A : Set} → Not (Not A) → A
Whoa ()

postulate
  -- Law of excluded middle.
  LEM : ∀ {A : Set} → Not (Not A) → A

Alright : ∀ {A : Set} → Not (Not A) → A
Alright p = LEM p

-- Constructive LEM requires hProp, hSet, Discrete, etc.
