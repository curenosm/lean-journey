def twice (action : IO Unit) : IO Unit := do
  action
  action

#eval "Hello...   ".dropRightWhile (fun c => not (c.isAlphanum))
#eval twice (IO.println "shy")

def nTimes (action : IO Unit) : Nat → IO Unit
  | 0 => pure ()
  | n + 1 => do
    action
    nTimes action n

def countdown : Nat → List (IO Unit)
  | 0 => [IO.println "Blast off!"]
  | n + 1 => IO.println s!"{n + 1}" :: countdown n

-- No imprime nada, sin embargo almacena tres IO action.
def from5 : List (IO Unit) := countdown 5

#eval from5.length


def runActions : List (IO Unit) → IO Unit
  | [] => pure ()
  | act :: actions => do
    act
    runActions actions

def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"

  let input ← stdin.getLine
  let name := input.dropRightWhile Char.isWhitespace

  stdout.putStrLn s!"Hello, {name}!"

def main2 : IO Unit := runActions from5

/-

-- Hacer la ejecucion de la siguiente función paso a paso
-- en un comentario como este.
-/

def main3 : IO Unit := do
  let englishGreeting := IO.println "Hello!"
  IO.println "Bonjour!"
  englishGreeting

#eval main3

/-
===
#eval main

1. La primera linea dentro de la función es no almacena un IO action
sino que almacena el resultado de la ejecución del siguiente:

$$ IO.println "Hello!" $$

2. En este caso almacena el IO action, pero no lo ejecuta,
únicamente detonaría la acción si IO.println fuera usado
después de una flecha, sin embargo no fue el caso.

3. Luego ejecuta el IO action de imprimir algo en stdout.

Bonjour!

4. Y finalmente llama el IO action, que termina por no
devolver nada.

===
-/
