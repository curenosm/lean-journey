def bufsize : USize := 20 * 1024

-- La función dump es declarada como parcial, porque
-- se llama a sí misma con entradas que no son inmediatamente más
-- pequeñas que el argumento.

-- Lean no requiere una prueba de que la función va a terminar.

partial def dump (stream : IO.FS.Stream) : IO Unit := do
  let buf ← stream.read bufsize

  -- Cuando un if ocurre dentro de un bloque do, se provee
  -- ímplicitamente otro bloque do en cada una de las ramas.

  -- Estos bloques introducen un nuevo alcance, afuera del cual
  -- las declaraciones no serán alcanzables.

  if buf.isEmpty then
    pure ()
  else
    let stdout ← IO.getStdout -- No alcanzable
    stdout.write buf
    dump stream -- Recursión de cola

-- IO.FS.Stream se trata de un stream POSIX
/-
===
structure Stream where
  flush   : IO Unit
  read    : USize → IO ByteArray
  write   : ByteArray → IO Unit
  getLine : IO String
  putStr  : String → IO Unit
===
-/

def fileStream (filename : System.FilePath) : IO (Option IO.FS.Stream) := do
  let fileExists ← filename.pathExists
  if not fileExists then
    let stderr ← IO.getStderr
    stderr.putStrLn s!"File not found: {filename}"
    pure none
  else
    let handle ← IO.FS.Handle.mk filename IO.FS.Mode.read
    pure (some (IO.FS.Stream.ofHandle handle))

def process (exitCode : UInt32) (args : List String) : IO UInt32 := do
  match args with
  | [] => pure exitCode
  | "-" :: args =>
    let stdin ← IO.getStdin
    dump stdin
    process exitCode args
  | filename :: args =>
    let stream ← fileStream ⟨filename⟩
    match stream with
    | none =>
      process 1 args
    | some stream =>
      dump stream
      process exitCode args

def main (args : List String) : IO UInt32 :=
  match args with
  | [] => process 0 ["-"]
  | _ =>  process 0 args

-- Ejercicio, extender la funcionalidad para que si se introduce
-- el término --help como argumento, imprima información pertinente
-- al uso del la utilidad.
