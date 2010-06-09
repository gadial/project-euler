-- By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6^(th) prime is 13.
-- 
-- What is the 10001^(st) prime number?
sieve (p:xs) = p : sieve(filter (\n -> n `mod` p /= 0) xs)

primes = sieve [2..]

result = last (take 10001 primes)
