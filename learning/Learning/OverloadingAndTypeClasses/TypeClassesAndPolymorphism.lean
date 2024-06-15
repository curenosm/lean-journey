
-- Arroja un tipo con metavariables
#check (IO.println)

-- Lean hace lo mejor por inferir el tipo
-- pero Lean no cuenta con información para determinar todos

-- Lo deshabilitamos con:
#check @IO.println


-- DEFINIENDO FUNCIONES POLIMORFICAS CON INSTANCIAS IMPLICITAS

-- Add nos permite sumar los diferentes elementod del tipo α
-- OfNat provee un valor implícito en caso de que se pase la
-- lista vacía.

def List.sum [Add α] [OfNat α 0] : List α → α
  | [] => 0
  | x :: xs => x + xs.sum

-- Con esto podemos crear una lista de naturales.
def fourNats : List Nat := [1, 2, 3, 4]

#eval fourNats.sum


-- No así de instancias de Pos
def fourNats : List Nat := [1, 2, 3, 4]

#eval fourNats.sum

-- Las especificaciones entre corchetes se conocen como
-- "Instance Implicits".

-- Los argumentos implicitos ordinarios y los instance implicits
-- es la estrategia que Lean utiliza para encontrar un valor
-- de argumento.

-- Para los ordinarios se usa algoritmo de unificacion

-- Mientras que para los instance implicits se consulta una
-- tabla integrada de valores de instancias.

-- Las instancias también pueden recibir argumentos instance implicits
-- ellas mismas.

-- Por ejemplo para un product type genérico, si quisieramos
-- proveer una instancia de Add para este tipo genérico,
-- debieramos también contar con una para α

structure PPoint (α : Type) where
  x : α
  y : α
deriving Repr

instance [Add α] : Add (PPoint α) where
  add p1 p2 := { x := p1.x + p2.x, y := p1.y + p2.y }


-- EJERCICIOS

-- Escribir una implementacion de OfNat para el type class
-- de numeros pares, para la instancias base se debe de escribir
-- OfNat Even Nat.zero en lugar de OfNat Even 0.

-- Hay un límite para el numero de busquedas recursivas de instancias
-- que Lean puede efectuar, esto pone un límite en el tamaño en
-- el tamaño de una literal numérica para el tipo Even del
-- ejercicio anterior, descubre cuál es ese límite experimentalmente
