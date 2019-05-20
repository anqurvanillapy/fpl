data torus where
| base
| p/1 (i : 𝕀) [∂[i] → base]
| p/2 (i : 𝕀) [∂[i] → base]
| square (i j : 𝕀)
  [ ∂[i] → p/1 j
  | ∂[j] → p/2 i
  ]
