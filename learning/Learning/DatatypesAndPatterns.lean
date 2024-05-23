import «Learning».Structs
namespace DatatypesAndPatterns
-- Product type (agrupacion)

-- Sum types, permiten diferentes alternativas

-- Recursive sum types are called inductive datatype

-- En Lean false y true son re-exportados para poder acceder sin Bool.false
/-
inductive Bool where
  | false : Bool
  | true : Bool

-- Otro ejemplo de tipo de dato inductivo es Nat
inductive Nat where
  | zero : Nat
  | succ (n : Nat) : Nat
-/

-- Ejemplos
#check Nat.succ (Nat.succ (Nat.succ (Nat.succ Nat.zero)))


def isZero (n : Nat) : Bool := match n with
  | Nat.zero => true
  | Nat.succ k => false

#check isZero 0
#check isZero Nat.zero

#eval isZero Nat.zero
#eval Nat.pred 5
#eval Nat.pred 839
#eval Nat.pred 0

open Structs

def depth (p : Point3D) : Float :=
  match p with
  | { x:= _, y := _, z := d } => d

def even (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (even k)

def odd (n : Nat) : Bool := not (even n)

#eval even 7
#eval odd 7


def plus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.succ (plus n k')

#eval plus (7 : Nat) (8 : Nat)

def prod (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => Nat.zero
  | Nat.succ k' => (plus n (prod n k'))

#eval prod (7 : Nat) (8 : Nat)


def times (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => Nat.zero
  | Nat.succ k' => plus n (times n k')

def minus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.pred (minus n k')

#eval minus (8 : Nat) (2 : Nat)






end DatatypesAndPatterns
