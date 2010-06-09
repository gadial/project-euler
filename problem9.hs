-- A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
-- a^(2) + b^(2) = c^(2)
-- 
-- For example, 3^(2) + 4^(2) = 9 + 16 = 25 = 5^(2).
-- 
-- There exists exactly one Pythagorean triplet for which a + b + c = 1000.
-- Find the product abc.

-- Very simplified if we recall that a pythagorean triplet is of the form c(u^2-v^2), c(2uv), c(u^2+v^2)
-- And so we want to find u,v such that (u(u+2v)) | 500 and we're done

divides n a = n `mod` a == 0

listAllPairs xs [] = []
listAllPairs xs (y:ys) = (map (,) xs) ++ listAllPairs xs ys


-- valsRange = [1..500]
-- solution = 
-- equation u v = u*(u+2*v)