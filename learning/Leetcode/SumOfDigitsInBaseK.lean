namespace Leetcode

def sum_of_digits (n : Nat) (k : Nat) : Nat :=
  let rec helper : Nat -> Nat -> Nat -> Nat
    | 0, _, acc => acc
    | m + 1, 0, acc => acc
    | m + 1, k, acc => helper ((m + 1) / k) k (acc + (m + 1) % k)
    termination_by n k acc => (n, k, acc)
    decreasing_by sorry
  helper n k 0

#eval sum_of_digits 34 6
#eval sum_of_digits 10 10

end Leetcode
