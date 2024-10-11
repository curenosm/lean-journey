import Lake
open Lake DSL

package «introduction» where
  -- add package configuration options here

lean_lib «Introduction» where
  -- add library configuration options here

@[default_target]
lean_exe «introduction» where
  root := `Main
