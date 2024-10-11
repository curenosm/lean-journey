def double (x : Nat) : Nat := x + x

#eval double 3 -- 6

-- Podemos pensar a def como un lambda nombrado, lo siguiente
-- arroja el mismo valor.

def double1 : Nat → Nat :=
  fun x => x + x

#eval double1 3

-- Podemos omitir las declaraciones de tipo cuando Lean dispone de suficiente
-- informacion para inferirlos.

def double2 :=
  fun (x : Nat) => x + x


-- En def foo : α := bar, normalmente Lean puede inferir la variable de tipo α
-- Pero es una buena idea ponerla de cualquier modo.

def pi := 3.141592654

-- def puede recibir varios parametros
def add (x y : Nat) :=
  x + y

#eval add 3 2               -- 5

-- O bien especificados en la firma de la siguiente forma:
def double3 (x : Nat) : Nat :=
 x + x

def add1 (x : Nat) (y : Nat) :=
  x + y

-- Aqui utilizamos la funcion double3 para crear el primer parametro de add1
#eval add1 (double3 3) (7 + 9)  -- 22

def greater (x y : Nat) :=
  if x > y then x
  else y

-- Podemos pasar funciones como argumentos

def doTwice (f : Nat → Nat) (x : Nat) : Nat :=
  f (f x)

#eval doTwice double 2   -- 8

-- Para ponerse mas abstractos podemos pasar tipos como argumentos

def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ := g (f x)

def square (x : Nat) : Nat :=
  x * x

#eval compose Nat Nat Nat double square 3  -- 18


-- Definiciones Locales
#check let y := 2 + 2; y * y   -- Nat
#eval  let y := 2 + 2; y * y   -- 16

def twice_double (x : Nat) : Nat :=
  let y := x + x; y * y

#eval twice_double 2   -- 16


#check let y := 2 + 2; let z := y + y; z * z   -- Nat
#eval  let y := 2 + 2; let z := y + y; z * z   -- 64

-- Podemos usar un salto de linea en lugar del punto y coma
def t (x : Nat) : Nat :=
  let y := x + x
  y * y

def foo := let a := Nat; fun x : a => x + 2
