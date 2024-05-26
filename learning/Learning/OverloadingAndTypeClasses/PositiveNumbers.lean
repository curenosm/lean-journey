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

end PositiveNumbers
