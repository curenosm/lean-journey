#eval String.append "Hello, " "Lean!"
#eval String.append "great " (String.append "oak " "tree")
#eval String.append "it is " (if 1 > 2 then "yes" else "no")

-- Evaluación parcial, devuelve una función que espera
-- los argumentos faltantes, al estilo de Haskell.
#eval (String.append "it is ") "yes"


-- Exercises
#eval 42 + 19
#eval 2 * 3 + 4
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7
#eval if 3 == 4 then "equal" else "not equal"
