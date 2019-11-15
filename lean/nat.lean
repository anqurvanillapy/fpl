inductive N : Type
| zero : N
| succ : N -> N

-- The recursor of `N`
#check @N.rec_on

namespace N

def add (m n : N) : N :=
N.rec_on m n (λ m' n', succ n')

-- 0 + 1
#reduce add zero (succ zero)

-- 1 + 1 = 2
theorem one_plus_one_eq_two
    : add (succ zero) (succ zero) = succ (succ zero)
    := rfl

end N
