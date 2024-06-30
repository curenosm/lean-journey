namespace Leetcode

def special_array_i (arr : Array Nat) : IO Bool :=
  let len := arr.size
  let rec loop (i : Nat) : IO Bool :=
    if i < len - 1 then do
      if arr[i]! % 2 == arr[i + 1]! then do
        return false
      loop (i + 1)
    else
      pure true
  loop 0


#eval special_array_i #[1, 2, 3, 4, 5]
#eval special_array_i #[4,3,1,6]

end Leetcode
