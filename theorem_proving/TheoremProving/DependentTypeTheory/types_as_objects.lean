

-- TIPOS COMO OBJETOS

#check Nat               -- Type
#check Bool              -- Type
#check Nat → Bool        -- Type
#check Nat × Bool        -- Type
#check Nat → Nat         -- ...
#check Nat × Nat → Nat
#check Nat → Nat → Nat
#check Nat → (Nat → Nat)
#check Nat → Nat → Bool
#check (Nat → Nat) → Nat

-- Declaramos un símbolo para referirnos a un tipo
def α : Type := Nat
def β : Type := Bool
-- def F : Type → Type := List

def G : Type → Type → Type := Prod

#check α        -- Type
-- #check F α      -- Type
-- #check F Nat    -- Type
#check G α      -- Type → Type
#check G α β    -- Type
#check G α Nat  -- Type

#check Prod α β       -- Type
#check α × β          -- Type

#check Prod Nat Nat   -- Type
#check Nat × Nat      -- Type

-- Listas genéricas
#check List α    -- Type
#check List Nat  -- Type


-- Jerarquía infinita de tipos
#check Type     -- Type 1
#check Type 1   -- Type 2
#check Type 2   -- Type 3
#check Type 3   -- Type 4
#check Type 4   -- Type 5


#check List    -- List.{u} (α : Type u) : Type u
#check Prod    -- Prod.{u, v} (α : Type u) (β : Type v) : Type (max u v)

-- Para definir constantes polimorficas, Lean
-- nos permite declarar variables de universo explicitamente usando
-- el comando universe


universe u

def F (α : Type u) : Type u := Prod α α

#check F
