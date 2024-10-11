#check fun (x : Nat) => x + 5
#check λ (x : Nat) => x + 5
-- λ y fun son la misma cosa
#check fun x => x + 5 -- Nat inferido
#check λ x => x + 5 -- Nat inferido


-- Evaluando un lambda
#eval (λ x : Nat => x + 5) 10 -- 15


-- Abstraccion lambda significa crear una funcion a partir de otra expresion
#check fun x : Nat => fun y : Bool => if not y then x + 1 else x + 2
#check fun (x : Nat) (y : Bool) => if not y then x + 1 else x + 2

-- Inferencia de tipos, pues se utiliza el uso en dicha expresion para
-- determinar el tipo de los argumentos de la funcion.
#check fun x y => if not y then x + 1 else x + 2   -- Nat → Bool → Nat

def f (n : Nat) : String := toString n
def g (s : String) : Bool := s.length > 0

#check fun x : Nat => x
#check fun _ : Nat => true
#check fun x : Nat => g (f x)
#check fun x => g (f x)

-- Podemos pasar funciones como parametros y usarlas en la implementacion.
#check fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
-- (String → Bool) → (Nat → String) → Nat → Bool

-- Tambien podemos pasar tipos como parametros.
def example_fun := fun (α β γ : Type) (g : β → γ) (f : α → β) (x : α) => g (f x)

#check example_fun

-------------------|---|---| Al evaluar pasamos como argumentos
--                 |   |   | los tipos.
#eval example_fun Nat Nat Nat (λ x => x + 5) (λ x => x + 5) 10

-- En este caso estamos efectuando polimorfismo

-- El alcance de un lambda es la expresion inmediata despues del =>

#check fun (α β: Type) (b : β) (x : α) => b
#check fun (α β: Type) (u : β) (z : α) => u

-- Expresiones que son las mismas salvo el renombrado de las variables
-- ligadas se llama alfa equivalentes

-- Lean es capaz de reconocer dicha equivalencia

#check (fun x : Nat => x) 1     -- Nat
#check (fun x : Nat => true) 1  -- Bool

def f1 (n : Nat) : String := toString n
def g1 (s : String) : Bool := s.length > 0

#check (fun (α β γ : Type) (u : β → γ) (v : α → β) (x : α) => u (v x))
  Nat String Bool g1 f1 0 -- Bool

#eval (fun x : Nat => x) 1     -- 1
#eval (fun x : Nat => true) 1  -- true

-- Dos terminos que se reducen al mismo valor se llaman definicionalmente
-- iguales
