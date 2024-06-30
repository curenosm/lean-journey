namespace Leetcode

def hammingDistance (m : Nat) (n : Nat) : Nat :=
  let rec helper : Nat -> Nat -> Nat -> Nat
    | 0    , 0    , d => d
    | 0    , n + 1, d => helper 0 ((n + 1) >>> 1) (d + (0 ^^^ ((n + 1) &&& 1)))
    | m + 1, 0    , d => helper ((m + 1) >>> 1) 0 (d + (((m + 1) &&& 1) ^^^ 0))
    | m + 1, n + 1, d => helper ((m + 1) >>> 1) ((n + 1) >>> 1) (d + (((m + 1) &&& 1) ^^^ ((n + 1) &&& 1)))
    helper m n 0

#eval hammingDistance 1 4
#eval hammingDistance 3 1
#eval hammingDistance 255 0
#eval hammingDistance 511 0
#eval hammingDistance 0 (2 ^ 9 - 1)

-- Un orden de magnitud más y no podremos visualizarlo en el infoview
def k : Nat := 10 ^ 5 -- 6
#eval k
#eval hammingDistance 0 (2 ^ k - 1)

end Leetcode
