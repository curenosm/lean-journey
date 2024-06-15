namespace Leetcode

def helper (n : Nat) (acc : Nat) (prev': Nat) (prev : Nat) := match n with
  | 0 => acc
  | 1 => acc
  | 2 => acc
  | k + 1 => let cur := prev' + prev
    helper k cur prev cur

def climb_stairs (n : Nat) := match n with
  | 0 => 1
  | 1 => 1
  | 2 => 2
  | k + 1 => helper (k + 1) 0 1 2

#eval climb_stairs 4
#eval climb_stairs 5
#eval climb_stairs 6
#eval climb_stairs 23

end Leetcode
