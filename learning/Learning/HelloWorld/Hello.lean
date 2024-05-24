def main : IO Unit := IO.println "Hello, world!"

-- Para correr un solo archivo
-- lean --run Hello.lean

-- El tipo sería IO α, representa que o va a arrojar un error
-- o devolver algo del tipo α, que en este caso no se devuelve
-- nada, pues unit representa la ausencia de valor.
