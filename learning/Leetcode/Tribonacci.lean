namespace Leetcode

def tribonacci (n : Nat) := match n with
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | k + 1 => (tribonacci k) + (tribonacci (k - 1)) + (tribonacci (k - 2))

#eval tribonacci 25 -- 1389537

end Leetcode
