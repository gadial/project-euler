# Consider the consecutive primes p_(1) = 19 and p_(2) = 23. It can be verified that 1219 is the smallest number such that the last digits are formed by p_(1) whilst also being divisible by p_(2).
# 
# In fact, with the exception of p_(1) = 3 and p_(2) = 5, for every pair of consecutive primes, p_(2) > p_(1), there exist values of n for which the last digits are formed by p_(1) and n is divisible by p_(2). Let S be the smallest of these values of n.
# 
# Find ∑ S for every pair of consecutive primes with 5 ≤ p_(1) ≤ 1000000.

require 'common'

max = 1000000

#solves the equation ax=b (mod n)
def solve(a,b,n)
    (b*a.inverse_modulo(n)) % n
end

def find_s_for_pair(p1,p2)
    n = 10**p1.number_of_digits
    p2*solve(p2,p1,n)
end

primes = $Primes.reject{|p| p <= 3}

sum = 0
while primes.first < max
    sum += find_s_for_pair(primes.shift, primes.first)
end
puts sum
