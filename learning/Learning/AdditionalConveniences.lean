namespace AdditionalConveniences

def length (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length ys)

def length2 : List α → Nat
  | [] => 0
  | _ :: ys => Nat.succ (length ys)

def drop : Nat → List α → List α
  | Nat.zero, xs => xs
  | _, [] => []
  | Nat.succ n, _ :: xs => drop n xs

def fromOption (default : α) : Option α → α
  | none => default
  | some x => x

#eval (some "salmonberry").getD ""

#eval none.getD ""

-- Ejemplo usando pattern matching, recibe una lista de parejas
-- y devuelve una pareja de listas.

-- Es lenta esta función, pues requiere un número exponencial de
-- llamadas en el stack.

def unzip : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys => (x :: (unzip xys).fst, y :: (unzip xys).snd)

def unzip2 : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let unzipped : List α × List β := unzip xys
    (x :: unzipped.fst, y :: unzipped.snd)

-- Podemos escribirlo así, pues pair tiene un único constructor.

def unzip3 : List (α × β) → List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) : List α × List β := unzip xys
    (x :: xs, y :: ys)

-- La diferencia entre def y let es que si se trata de una llamada
-- recurisiva, entonces se tiene que indicar de manera explícita.ß

-- Top Level
def reverse (xs : List α) : List α :=
  -- Local
  let rec helper : List α → List α → List α
    | [], soFar => soFar
    | y :: ys, soFar => helper ys (y :: soFar)
    helper xs []

#eval reverse [1, 2, 3]
#eval reverse ['a', 'b', 'c']

-- Si el cuerpo es una expresión match, entonces podemos usar la
-- inferencia para omitir el tipo de unzip4.

def unzip4 (pairs : List (α × β)) :=
  match pairs with
  | [] => ([], [])
  | (x, y) :: xys =>
    let unzipped := unzip xys
    (x :: unzipped.fst, y :: unzipped.snd)


-- Inferencia de tipos

#check 14
#check (14 : Int)

-- Lean puede derminar el tipo de retorno, pero si omitimos el de
-- ingreso, no será capaz en este caso.

def id (x : α) := x



-- Matching Simultáneo

def drop2 (n : Nat) (xs : List α) : List α :=
  match n, xs with
  | Nat.zero, ys => ys
  | _, [] => []
  | Nat.succ n , _ :: ys => drop n ys


-- Patrones con números naturales

-- Los argumentos para el operador + sirven un fin distinto
-- el cuál es el rol de constructor.

-- "Envuelve" 1 vez al natural "n" en un Constructor de Nat.succ
def even : Nat → Bool
  | 0 => true
  | n + 1 => not (even n)

-- La siguiente función:

def halve : Nat → Nat
  | Nat.zero => 0
  | Nat.succ Nat.zero => 0
  | Nat.succ (Nat.succ n) => halve n + 1

-- Se puede escribir, de manera más concisa:

def halve1 : Nat → Nat
  | 0 => 0
  | 1 => 0
  | n + 2 => halve n + 1

-- Al usar dicha sintaxis, el segundo argumento de + debe ser un Nat



-- FUNCIONES ANONIMAS

#check fun x => x + 1

-- Con anotaciones de tipos
#check fun (x : Int) => x + 1


#check fun {α : Type} (x : α) => x

-- Lean permite el uso de lambda en lugar de fun
-- aunque no es tan frecuente encontrarselo.

#check λ {α : Type} (x : α) => x


-- También podemos usar el matching multiple
#check fun
  | 0 => none
  | n + 1 => some n

/-
-- En realidad es azúcar sintáctica de la siguiente
-- expresión, donde se introduce una variable nombrada.
fun x =>
  match x with
  | 0 => none
  | Nat.succ n => some n : Nat → Option Nat
-/

-- También al momento de introducir una definición
-- que recibe valores.

-- Para casos muy sencillos
#check (· + 1)
#check (· , ·) 1 2

#eval (fun x => x + x) 5
#eval (· * 2) 5

-- NAMESPACES

-- Cualquier símbolo o identificador (o nombre)
-- ocurre en un namespace (espacio de nombres) lo
-- cual es una colección de nombres.

-- Podemos definir un nombre asociandolo al namespace
-- Nat directamente.

-- def Nat.double (x : Nat) : Nat := x + x
-- #eval (4 : Nat).double

-- Introduciendo una secuencia de declaraciones
-- por medio del comando namespace.

namespace NewNamespace
def triple (x : Nat) : Nat := 3 * x
def quadruple (x : Nat) : Nat := 2 * x + 2 * x
end NewNamespace

#check NewNamespace.triple
#check NewNamespace.quadruple

-- Podemos abrir un namespace lo cuál hace accesibles
-- sus nombres en la expresión inmediata siguiente.

def timesTwelve (x : Nat) :=
  open NewNamespace in
  quadruple (triple x)

-- O antes de un comando de Lean
open NewNamespace in

-- La firma contiene el namespace completo
#check quadruple

-- O para todo el resto del archivo, omitimos "in"
open NewNamespace


-- IF LET

-- Para un tipo suma, si un sólo constructor es
-- de interés como sigue:
inductive Inline : Type where
  | lineBreak
  | string : String → Inline
  | emph : Inline → Inline
  | strong : Inline → Inline

/-
def Inline.string? (inline : Inline) : Option String :=
  match inline with
  | Inline.string s => some s
  | _ => none
-/

def Inline.string? (inline : Inline) : Option String :=
  if let Inline.string s := inline then
    some s
  else none

-- Podemos instanciar estructuras
-- con parentesis angulares
-- \< y \>


-- STRING INTERPOLATION

#eval s!"three fives is {NewNamespace.triple 5}"

-- No podemos interpolar cualquier cosa
-- por ejemplo una función no se podría

-- #check s!"three fives is {NewNamespace.triple}"

-- Necesitamos proveer una instancia
-- deriving Repr
-- para poder interpolarlo


end AdditionalConveniences
