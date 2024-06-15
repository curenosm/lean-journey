import «Learning».«OverloadingAndTypeClasses».Intro
import «Learning».«OverloadingAndTypeClasses».PositiveNumbers
namespace ControllingInstanceSearch

-- Algunas veces puede ser util el ser flexibles y permitir que se pueda
-- sumar tipos heterogeneos

open Intro (Pos)

def addNatPos : Nat → Pos → Pos
  | 0, p => p
  | n + 1, p => Pos.succ (addNatPos n p)

def addPosNat : Pos → Nat → Pos
  | p, 0 => p
  | p, n + 1 => Pos.succ (addPosNat p n)

-- Esto nos permite sumar una instancia de Nat con un número Pos

-- Overloading Heterogéneo

instance : HAdd Nat Pos Pos where
  hAdd := addNatPos

instance : HAdd Pos Nat Pos where
  hAdd := addPosNat

-- Esto nos permite usar la notación estandar para la suma
#eval (3 : Pos) + (5 : Nat)
#eval (3 : Nat) + (5 : Pos)

-- La definición de HAdd es similar a la siguiente

class HPlus (α : Type) (β : Type) (γ : Type) where
  hPlus : α → β → γ

instance : HPlus Nat Pos Pos where
  hPlus := addNatPos

instance : HPlus Pos Nat Pos where
  hPlus := addPosNat


end ControllingInstanceSearch
