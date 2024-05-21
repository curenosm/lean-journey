#check 1.2

-- Los structs son tipos irreducibles
#check -454.2123215
#check 0.0
#check 0
#check (0 : Float)

structure Point where
  x : Float
  y : Float
deriving Repr

def origin : Point := { x := 0.0, y := 0.0 }
#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))

#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }


structure Point3D where
  x : Float
  y : Float
  z : Float
deriving Repr

def origin3D : Point3D := { x := 0.0, y := 0.0, z := 0.0 }
#check ({ x := 0.0, y := 0.0 } : Point)
#check { x := 0.0, y := 0.0 : Point}

def zeroX (p : Point) : Point := { x := 0, y := p.y }

-- No modifica el estado, sino que crea una estructura nueva
def zeroX2 (p : Point) : Point := { p with x := 0 }

def fourAndThree : Point := { x := 4.3, y := 3.4 }
#eval fourAndThree
#eval zeroX fourAndThree
#eval fourAndThree


-- Namespace qualifier - nombre del constructor
#check Point.mk 1.2 2.8 -- No es estándar, se recomienda el primer enfoque

#check (Point.mk)
#check (Point.x)
#check (Point.y)


#eval "one string".append " and another"


def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  { x := f p.x, y := f p.y }

#eval fourAndThree.modifyBoth Float.floor



-- Ejercicios

-- TODO: Define a structure named RectangularPrism that contains the height,
-- width, and depth of a rectangular prism, each as a Float.

-- TODO: Define a function named volume : RectangularPrism → Float that computes the
-- volume of a rectangular prism.

-- TODO: Define a structure named Segment that represents a line segment by its
-- endpoints, and define a function length : Segment → Float that computes the
-- length of a line segment. Segment should have at most two fields.

-- TODO: Which names are introduced by the declaration of RectangularPrism?

-- TODO: Which names are introduced by the following declarations of Hamster
-- and Book? What are their types?
