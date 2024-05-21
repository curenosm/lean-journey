import Lake
open Lake DSL

package «learning» where
  -- add package configuration options here

lean_lib «Learning» where
  -- add library configuration options here

@[default_target]
lean_exe «learning» where
  root := `Main
