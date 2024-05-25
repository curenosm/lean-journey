import «Greeting»
import Greeting.Smile

-- Import se utiliza para hacer los contenidos
-- de un directorio accesibles, mientras
-- que open hace lo respectivo pero para los
-- espacios de nombres.

-- NO TODO DIRECTORIO ES UN NAMESPACE

-- También podemos importar nombres distinguidos

open Nat (toFloat)

def main : IO Unit :=
  IO.println s!"Hello, {hello}! {expression}"
