# Let p_(n) be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when (p_(n)−1)^(n) + (p_(n)+1)^(n) is divided by p_(n)^(2).
# 
# For example, when n = 3, p_(3) = 5, and 4^(3) + 6^(3) = 280 ≡ 5 mod 25.
# 
# The least value of n for which the remainder first exceeds 10^(9) is 7037.
# 
# Find the least value of n for which the remainder first exceeds 10^(10).

#This problem is very similar to problem 120. Again, we have
#(p_(n)−1)^(n) + (p_(n)+1)^(n) = 2 if n is even, else 2*n*p.

require 'common'

n = 1
max = 10**10
while true
    break if 2*n*$Primes[n-1] > max
    n += 2
end

puts n
