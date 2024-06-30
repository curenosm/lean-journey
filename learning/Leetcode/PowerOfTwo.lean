namespace Leetcode

def natToBinary (n : Nat) : String :=
  let rec natToBinaryAux : Nat → String → String
  | 0    , acc => if acc.isEmpty then "0" else acc
  | n + 1, acc => natToBinaryAux ((n + 1) / 2) ((if (n + 1) % 2 == 0 then "0" else "1") ++ acc)
  natToBinaryAux n ""

#eval natToBinary 2
#eval natToBinary 10
#eval natToBinary 111111111111111

end Leetcode
