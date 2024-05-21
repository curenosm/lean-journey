-- This module serves as the root of the `Learning` library.
-- Import modules here that should be built as part of the library.
import «Learning».Basic

--structure Add (a : Type) where
--  add : a → a → a

#check @Add.add
-- Add.add : {a : Type} -> Add a -> a -> a


def double (s : Add a) (x : a) : a :=
  s.add x x

#eval double { add := Nat.add } 10
-- 20

#eval double { add := Nat.mul } 10
-- 100

#eval double { add := Int.add } 10
-- 20



namespace Ex

class Add (a : Type) where
  add : a -> a -> a

#check @Add.add
-- Add.add : {a : Type} → [self : Add a] → a → a → a

instance : Add Nat where
  add := Nat.add


instance [Add a] : Add (Array a) where
  add x y := Array.zipWith x y (· + ·)

#eval Add.add #[1, 2] #[3, 4]
-- #[4, 6]

#eval #[1, 2] + #[3, 4]
-- #[4, 6]

end Ex
