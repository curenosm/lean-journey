-- Probando 0 + a = a
/-
induction n with d hd
rw [add_zero]
rfl
rw [add_succ 0]
rw [hd]
rfl
-/
