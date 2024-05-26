def woodlandCritters : List String :=
  ["hedgehog", "deer", "snail"]

-- rfl: reflexivity
-- def onePlusOneIsTwo : 1 + 1 = 2 := rfl

-- Cuando una proposición es provada, se dice que es un teorema

def OnePlusOneIsTwo : Prop := 1 + 1 = 2

-- theorem onePlusOneIsTwo : OnePlusOneIsTwo := rfl

-- Para declarar una prueba por tácticas utilizamos 'by'.
theorem onePlusOneIsTwo : 1 + 1 = 2 := by
  simp -- simplify


-- Conectivos Lógicos

theorem andImpliesOr : A ∧ B → A ∨ B :=
  fun andEvidence =>
    match andEvidence with
    | And.intro a _ => Or.inl a

theorem onePlusOneAndLessThan : 1 + 1 = 2 ∨ 3 < 5 := by simp
theorem notTwoEqualFive : ¬(1 + 1 = 5) := by simp
theorem trueIsTrue : True := True.intro
theorem trueOrFalse : True ∨ False := by simp
theorem falseImpliesTrue : False → True := by simp

-- Para asegurarnos de introducir condiciones que hagan
-- que nuestras construcciones sean seguras, es la de decorar
-- la firma con una validación.

def third (xs : List α) (ok : xs.length > 2) : α := xs[2]

-- Podemos indexar sin evidencia.
def thirdOption (xs : List α) : Option α := xs[2]?

#eval thirdOption woodlandCritters

-- Retorna un error en tiempo de compilación.
#eval woodlandCritters[1]!


-- Exercises
-- Prove the following theorems using rfl: 2 + 3 = 5, 15 - 8 = 7,
-- "Hello, ".append "world" = "Hello, world". What happens if rfl is used to
-- prove 5 < 18? Why?

-- Prove the following theorems using by simp: 2 + 3 = 5, 15 - 8 = 7,
-- "Hello, ".append "world" = "Hello, world", 5 < 18.

-- Write a function that looks up the fifth entry in a list. Pass the evidence
-- that this lookup is safe as an argument to the function.
