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

-- TODO: Define the function joinStringsWith with type
-- String -> String -> String -> String that creates a new string by placing
-- its first argument between its second and third arguments. joinStringsWith
-- ", " "one" "and another" should evaluate to "one, and another".

def joinStringsWith (first: String) (second: String) (third: String) :=
  String.append second (String.append first third)

#eval joinStringsWith ", " "one" "and another"

-- TODO: What is the type of joinStringsWith ": "? Check your answer with Lean.
-- Res: Deberia ser String -> String -> String

#check joinStringsWith ", "

-- TODO: Define a function volume with type Nat → Nat → Nat → Nat that computes
-- the volume of a rectangular prism with the given height, width, and depth.
def volume (height : Nat) (width : Nat) (depth : Nat) :=
  height * width * depth

#eval volume 2 2 2


-- Definiendo tipos

-- Abreviando un tipo
def Str : Type := String

def aStr : Str := "This is a string."
#eval aStr

def NaturalNumber : Type := Nat
def thirtyEight : NaturalNumber := (38 : Nat)

-- Aunque es preferible
abbrev N : Type := Nat

-- Se marcan como reducibles
def thirtyNine : N := 39
#eval thirtyNine
