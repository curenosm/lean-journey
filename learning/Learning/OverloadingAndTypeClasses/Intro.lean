namespace Intro

inductive Pos : Type where
  | one : Pos
  | succ : Pos → Pos

def seven : Pos :=
  Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))

-- Similares a los traits en Rust
-- O a las mismas Type Classes en Haskell.

class Plus (α : Type) where
  plus : α → α → α

instance : Plus Nat where
  plus := Nat.add

#eval Plus.plus 5 3

-- Podemos abrir el namespace que, por defecto, se introduce al declarar
-- la instancia con sus métodos.

open Plus (plus)

#eval plus 5 3


def Pos.plus : Pos → Pos → Pos
  | Pos.one, k => Pos.succ k
  | Pos.succ n, k => Pos.succ (n.plus k)

instance : Plus Pos where
  plus := Pos.plus

def fourteen : Pos := plus seven seven

end Intro
