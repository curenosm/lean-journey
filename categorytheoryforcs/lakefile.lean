import Lake
open Lake DSL

package "categorytheoryforcs" where
  -- add package configuration options here

lean_lib «Categorytheoryforcs» where
  -- add library configuration options here

@[default_target]
lean_exe "categorytheoryforcs" where
  root := `Main
