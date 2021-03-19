variables Z : ℤ → Prop
variables z : ℤ
variables n : ℕ

def set_of_Z : set ℤ := set_of Z
def set_of_N : set ℤ := {z | z = int.of_nat n}

def N_subset_Z := set.subset (set_of_N n) (set_of_Z Z)
