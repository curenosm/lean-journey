import «Learning».«OverloadingAndTypeClasses».Intro
namespace PositiveNumbers

-- El operador de adición integrado por defecto en Lean es azúcar sintáctico
-- para un Type Class llamado HAdd (Heterogenous Addition) que nos permite
-- sumar dos tipos diferentes para devolver el tipo mas general como cuando se
-- suman 1 + 2.4


-- Es decir que cuando escribimos x + y, en realidad se interpreta como
-- HAdd.hAdd x y

-- También tenemos disponible un tipo más sencillo, que no permite que se operen
-- dos tipos distintos el cuál es accesible como Add.

open Intro (Pos seven)

instance : Add Pos where
  add := Pos.plus

def fourteen : Pos := seven + seven


-- Conversion to Strings

-- Otra Type Class útil, es ToString, que nos permite mostrar un
-- valor en String que podemos utilizar para las interpolaciones e
-- impresiones en la salida estandar.

-- Ejemplo

def posToString (atTop : Bool) (p: Pos) : String :=
  let paren s := if atTop then s else "(" ++ s ++ ")"
    match p with
    | Pos.one => "Pos.one"
    | Pos.succ n => paren s!"Pos.succ {posToString false n}"

#eval posToString true seven

-- Para usar esta función declaramos en la instancia su uso.
instance : ToString Pos where
  toString := posToString true

#eval s!"There are {seven}"

-- También podemos generar un output más corto, haciendo uso del
-- hecho de que hay una correspondencia entre los positivos y los
-- naturales.

def Pos.toNat : Pos -> Nat
  | Pos.one => 1
  | Pos.succ n => (toNat n) + 1

-- Cuando hay más de una instancia definida, la última toma precedencia
instance : ToString Pos where
  toString x := toString (Pos.toNat x)

#eval s!"There are {seven}"


-- Sobrecargando la multiplicacion

def Pos.mul : Pos → Pos → Pos
 | Pos.one, k => k
 | Pos.succ n, k => (Pos.mul n k) + k

instance : Mul Pos where
  mul := Pos.mul

#eval [seven * Pos.one,
       seven * seven,
       Pos.succ Pos.one * seven]

-- α es el tipo que para el cual el natural está siendo sobrecargado
-- el natural sin nombre representa la literal numerica que se esta procesando

/-
class OfNat (α : Type) (_ : Nat) where
  ofNat : α
-/

-- Es decir que los argumentos de un type class no tienen por qué ser tipos

-- Con lo que nos facilita implementar en tipos y valores especificos

inductive LT4 where
  | zero
  | one
  | two
  | three
deriving Repr

-- Por ejemplo en este caso, los valores 0, 1, 2, 3 deberían poder
-- sobrecargarse

instance : OfNat LT4 0 where
  ofNat := LT4.zero

instance : OfNat LT4 1 where
  ofNat := LT4.one

instance : OfNat LT4 2 where
  ofNat := LT4.two

instance : OfNat LT4 3 where
  ofNat := LT4.three

#eval (3 : LT4)


-- En este caso fallaría
-- #eval (4 : LT4)


instance : OfNat Pos (n + 1) where
  ofNat :=
    let rec natPlusOne : Nat → Pos
      | 0 => Pos.one
      | k + 1 => Pos.succ (natPlusOne k)
    natPlusOne n

-- Y de ese modo, podemos efectuar
def eight : Pos := 8

-- Pero no
-- def zero : Pos := 0

-- EJERCICIOS

/-
Another Representation
An alternative way to represent a positive number is as the successor of some
Nat. Replace the definition of Pos with a structure whose constructor is named
succ that contains a Nat:

structure Pos where
  succ ::
  pred : Nat

Define instances of Add, Mul, ToString, and OfNat that allow this version of
Pos to be used conveniently.
-/

structure Pos where
  succ ::
  pred : Nat

/-
Even Numbers
Define a datatype that represents only even numbers. Define instances of Add,
Mul, and ToString that allow it to be used conveniently. OfNat requires a
feature that is introduced in the next section.
-/

/-
HTTP Requests
An HTTP request begins with an identification of a HTTP method, such as GET or
POST, along with a URI and an HTTP version. Define an inductive type that
represents an interesting subset of the HTTP methods, and a structure that
represents HTTP responses. Responses should have a ToString instance that makes
it possible to debug them. Use a type class to associate different IO actions
with each HTTP method, and write a test harness as an IO action that calls each
method and prints the result.
-/


end PositiveNumbers
