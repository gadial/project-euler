-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
-- 
-- Find the largest palindrome made from the product of two 3-digit numbers.

listTensorProduct xs [] = []
listTensorProduct xs (y:ys) = (map (*y) xs) ++ listTensorProduct xs ys

numToArray n
  | n < 10 = [n]
  | otherwise = (numToArray (n `div` 10)) ++ [n `mod` 10]

palindromeArray xs
  | length xs <= 1 = True
  | head xs == last xs = (palindromeArray . tail . init) xs
  | otherwise = False
  
palindrome = palindromeArray . numToArray 

numRange = [100..999]

result = (maximum . filter palindrome) (listTensorProduct numRange numRange)