import Lake
open Lake DSL

package «theorem_proving» where
  -- add package configuration options here

lean_lib «TheoremProving» where
  -- add library configuration options here

@[default_target]
lean_exe «theorem_proving» where
  root := `Main
