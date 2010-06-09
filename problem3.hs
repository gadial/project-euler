-- The prime factors of 13195 are 5, 7, 13 and 29.
-- 
-- What is the largest prime factor of the number 600851475143 ?

factors n = factorsAtLeast 2 n
  where factorsAtLeast minVal n
	  | n <= 1 		= []
	  | n `mod` minVal == 0 = minVal : factorsAtLeast minVal (n `div` minVal)
	  | otherwise 		= factorsAtLeast (minVal+1) n
    
value = 600851475143
result = maximum (factors value)
