# Feline

Una herramienta para visualizar texto y archivos
escrita en Lean 4.

## Instrucciones de compilación

```bash
lake build
```

## Instrucciones de ejecución

```bash
./.lake/build/bin/feline
```

## Pruebas

```bash
echo "It works!" | ./build/bin/feline
./.lake/build/bin/feline README.md
./.lake/build/bin/feline README.md lakefile.lean
echo "And purr" | ./.lake/build/bin/feline README.md - lakefile.lean
```