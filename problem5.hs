-- 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
-- 
-- What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?

my_gcd a b 
  | a < b = my_gcd b a
  | b == 0 = a
  | b > 0 = my_gcd b (a `mod` b)

my_lcm a b = (a*b) `div` (my_gcd a b)

my_lcm_list (n:ns) = foldl my_lcm n ns
    
numbers_up_to n
  | n <= 0 = []
  | n >= 1 = (numbers_up_to (n-1)) ++ [n]
  
result = my_lcm_list(numbers_up_to 20)