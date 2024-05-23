namespace Polymorphism
-- Convencion en Lean es utilizar letras griegas para
-- representar los tipos de datos.
structure PPoint (α : Type) where
  x : α
  y : α
deriving Repr

#eval PPoint.mk 3 6

def natOrigin : PPoint Nat :=
  { x := Nat.zero, y := Nat.zero }

#eval natOrigin

#eval PPoint.mk 'a' 'b'

-- Esta función es polimorfica, pues recibe como primer
-- argumento al que se hará referencia en la propia firma de
-- la función.

def replaceX (α : Type) (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX }

#check (replaceX)
#check replaceX Nat

#check replaceX Nat natOrigin
#check replaceX Nat natOrigin 5
#eval replaceX Nat natOrigin 5


inductive Sign where
  | pos
  | neg


def posOrNegThree (s : Sign) : match s with | Sign.pos => Nat | Sign.neg => Int :=
  match s with
  | Sign.pos => (3 : Nat)
  | Sign.neg => (-3 : Int)

def primesUnder10 : List Nat := [2, 3, 5, 7]

/-
inductive List (α : Type) where
  | nil : List α
  | cons : α → List α → List α
-/

def explicitPrimesUnder10 : List Nat :=
  List.cons 2 (List.cons 3 (List.cons 5 (List.cons 7 List.nil)))

def length (α : Type) (xs : List α) : Nat :=
  match xs with
  | List.nil => Nat.zero
  | List.cons _ ys => Nat.succ (length α ys)

/-
def length (α : Type) (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | y :: ys => Nat.succ (length α ys)
-/


-- ARGUMENTOS EXPLÍCITOS
def replaceX2 {α : Type} (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX }

-- Se infiere el tipo α
#eval replaceX2 natOrigin 5


def length2 {α : Type} (xs : List α) : Nat :=
  match xs with
  | List.nil => 0
  | List.cons _ ys => Nat.succ (length2 ys)

-- Como la función es nombrada List.length en la stdlib, se puede usar así
#eval List.length primesUnder10

#eval primesUnder10.length


#check List.length (α := Int)

def head? {α : Type} (xs : List α) : Option α :=
  match xs with
  | List.nil => none
  | List.cons y _ => some y

-- Convenciones Lean sufijos: ? Devuelve un Option, ! Puede fallar con
-- inputs invalidos, D devuelve un valor por defecto si falla
#eval primesUnder10.head?
#eval [].head? (α := Int)


structure Prod (α : Type) (β : Type) : Type where
  fst : α
  snd : β


def fives : String × Int := { fst := "five", snd := 5 }
def fives' : String × Int := ("five", 5)

-- Associatividad a la derecha en los tipos prod

def sevens : String × Int × Nat := ("VII", 7, 4 + 3)
def sevens' : String × (Int × Nat) := ("VII", (7, 4 + 3))

/-
inductive Sum (α : Type) (β : Type) : Type where
  | inl : α → Sum α β
  | inr : β → Sum α β
-/

def PetName : Type := String ⊕ String
def animals : List PetName :=
  [Sum.inl "Spot", Sum.inr "Tiger", Sum.inl "Fifi", Sum.inl "Rex", Sum.inr "Floof"]

def howManyDogs (pets : List PetName) : Nat :=
  match pets with
  | [] => 0
  | Sum.inl _ :: morePets => howManyDogs morePets + 1
  | Sum.inr _ :: morePets => howManyDogs morePets

/-
inductive Unit : Type where
  | unit : Unit
-/

inductive ArithExpr (ann : Type) : Type where
  | int : ann → Int → ArithExpr ann
  | plus : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | minus : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann
  | times : ann → ArithExpr ann → ArithExpr ann → ArithExpr ann

#eval (() : Unit)

inductive MyType (α : Type) : Type where
  | ctor : α → MyType α

def ofFive : MyType Nat := MyType.ctor 5

-- TODO: Write a function to find the last entry in a list. It should return an
--  Option.

-- TODO: Write a function that finds the first entry in a list that satisfies a
-- given predicate. Start the definition with def List.findFirst? {α : Type}
-- (xs : List α) (predicate : α → Bool) : Option α :=

-- TODO: Write a function Prod.swap that swaps the two fields in a pair. Start
--  the definition with def Prod.swap {α β : Type} (pair : α × β) : β × α :=

-- TODO: Rewrite the PetName example to use a custom datatype and compare it to
-- the version that uses Sum.

-- TODO:Write a function zip that combines two lists into a list of pairs. The
--  resulting list should be as long as the shortest input list. Start the
--  definition with def zip {α β : Type} (xs : List α) (ys : List β) : List
--  (α × β) :=.

-- TODO: Write a polymorphic function take that returns the first n entries in
-- a list, where n is a Nat. If the list contains fewer than n entries, then the
-- resulting list should be the input list. #eval take 3 ["bolete", "oyster"]
-- should yield ["bolete", "oyster"], and #eval take 1 ["bolete", "oyster"]
-- should yield ["bolete"].

-- TODO: Using the analogy between types and arithmetic, write a function that
-- distributes products over sums. In other words, it should have type
-- α × (β ⊕ γ) → (α × β) ⊕ (α × γ).

-- TODO: Using the analogy between types and arithmetic, write a function that
-- turns multiplication by two into a sum. In other words, it should have type
-- Bool × α → α ⊕ α.


end Polymorphism
