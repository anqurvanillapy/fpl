variables Z : ℤ → Prop
variables z : ℤ

def set_of_Z := set_of Z
def set_of_N := {n | n = z}

def N_subset_Z := set.subset (set_of_N z) (set_of_Z Z)
