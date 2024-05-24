-- En un bloque do, los bindings locales introducidos usando let
-- están disponibles en todas las sentencias del bloque do. A diferencia
-- de en otro lado que sólo son inmediatamente accesibles.

-- Usar una flecha para la asignación significa que se recibe una
-- IO action, para ejecutarse y (posiblemente) obtener el valor
-- nombrado de regreso.

-- Es decir que si IO.getStdin tiene tipo IO α, entonces
-- stdin tiene tipo α en lo que queda del bloque do.

def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"
  let input ← stdin.getLine

  -- Aquí se utiliza := porque no se trata de un IO action.
  -- Sino que String.dropRightWhile es una función común y corriente.

  let name := input.dropRightWhile Char.isWhitespace

  stdout.putStrLn s!"Hello, {name}!"
