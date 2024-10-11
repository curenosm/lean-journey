namespace VariablesAndSections

def compose (α β γ : Type) (g : β -> γ) (f : α -> β) (x : α) : γ :=
  g (f x)

def doTwice (α : Type) (h : α -> α) (x : α) : α :=
  h (h x)

-- def doThrice (α : Type) ()

end VariablesAndSections
