-- Computadoras y la prueba de teoremas

-- Lean está basadp en una version de un sistema conocido como
-- Cálculo de Construcciones con Tipos Inductivos


theorem and_commutative (p q : Prop) : p ∧ q → q ∧ p :=
  fun hpq : p ∧ q =>
  have hp : p := And.left hpq
  have hq : q := And.right hpq
  show q ∧ p from And.intro hq hp
