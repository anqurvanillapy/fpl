inductive N : Type
| zero : N
| succ : N -> N

-- The recursor of `N`
#check @N.rec_on

namespace N

def add (m n : N) : N :=
-- If `n` is 0, give out `m`; if not, sending `n` as `succ n'` with `(add m n')`
-- to `(λ n' add_m_n', succ add_m_n')`
N.rec_on n m (λ n' add_m_n', succ add_m_n')

#reduce add (succ zero) (succ (succ (succ zero)))

theorem one_plus_one_eq_two
    : add (succ zero) (succ zero) = succ (succ zero)
    := rfl

end N

#check N.one_plus_one_eq_two
