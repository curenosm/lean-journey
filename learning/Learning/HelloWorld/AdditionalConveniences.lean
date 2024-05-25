def bufsize : USize := 20 * 1024

-- Si queremos utilizar el resultado de un IO action inmediatamente
-- pues sólo se utiliza una vez, podemos hacer los siguiente.

partial def dump (stream : IO.FS.Stream) : IO Unit := do
  let buf ← stream.read bufsize
  if buf.isEmpty then
    pure ()
  else
    (← IO.getStdout).write buf
    dump stream

-- Lo mismo para la función fileStream

def fileStream (filename : System.FilePath) : IO (Option IO.FS.Stream) := do
  if not (← filename.pathExists) then
    (← IO.getStderr).putStrLn s!"File not found: {filename}"
    pure none
  else
    -- A veces no conviene, pues el código se vuelve más complicado de leer
    let handle ← IO.FS.Handle.mk filename IO.FS.Mode.read
    pure (some (IO.FS.Stream.ofHandle handle))

-- Otro ejemplo
def getNumA : IO Nat := do
  (← IO.getStdout).putStrLn "A"
  pure 5

def getNumB : IO Nat := do
  (← IO.getStdout).putStrLn "B"
  pure 7

/-
def test : IO Unit := do
  let a : Nat := if (← getNumA) == 5 then 0 else (← getNumB)
  (← IO.getStdout).putStrLn s!"The answer is {a}"
-/

-- Que es equivalente a:
def test' : IO Unit := do
  let x ← getNumA
  let y ← getNumB
  let a : Nat := if x == 5 then 0 else y
  (← IO.getStdout).putStrLn s!"The answer is {a}"

-- Pues las acciones anidadas, son "elevadas" al bloque
-- do que la encierra inmediatamente.

-- También podemos utilizar llaves en los bloques do y punto y coma
-- para incluir dos sentencias en el mismo renglón:

-- Layout sensible a espacios en blanco
def main1 : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"
  let name := (← stdin.getLine).trim
  stdout.putStrLn s!"Hello, {name}!"

-- Tan explícita como sea posible.
def main2 : IO Unit := do {
  let stdin ← IO.getStdin;
  let stdout ← IO.getStdout;

  stdout.putStrLn "How would you like to be addressed?";
  let name := (← stdin.getLine).trim;
  stdout.putStrLn s!"Hello, {name}!"
}

-- Punto y coma para separar sentencias en un mismo renglón
def main3 : IO Unit := do
  let stdin ← IO.getStdin; let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"
  let name := (← stdin.getLine).trim
  stdout.putStrLn s!"Hello, {name}!"

-- Aunque el codigo Lean idiomatico no suele incluir estos elementos
-- es conveniente saber que existen.

-- Para los IO actions, #eval evalúa la expresión provista
-- y ejecuta el IO action resultante

/-
#eval runActions (countdown 3)
===
3
2
1
Blast off!
===
-/

-- Leer de ese modo de IO stdin, no funciona simplemente
-- devuelve input vacío.
