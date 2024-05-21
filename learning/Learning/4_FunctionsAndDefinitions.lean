def hello := "Hello"
#eval hello

def lean : String := "Lean"
#eval lean

#eval String.append hello (String.append " " lean)

def add1 (n : Nat) : Nat := n + 1
#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n

#eval maximum 7 3

#check add1
#check (maximum) -- Lo trata como una expresión ordinaria

-- Asociación a la derecha
-- Nat → Nat → Nat === Nat → (Nat → Nat).


-- Ejercicios
