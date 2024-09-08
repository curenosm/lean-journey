import Lake
open Lake DSL

package "howtoproveit" where
  -- add package configuration options here

lean_lib «Howtoproveit» where
  -- add library configuration options here

@[default_target]
lean_exe "howtoproveit" where
  root := `Main
