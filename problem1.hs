-- If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
-- 
-- Find the sum of all the multiples of 3 or 5 below 1000.

divides a b = a `mod` b == 0
dividesBy xs n = any (divides n) xs
multiplesOf vals upto = filter (dividesBy vals) [1..upto]

result = sum(multiplesOf [3,5] 999)