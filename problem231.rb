# The binomial coefficient ^(10)C_(3) = 120.
# 120 = 2^(3) × 3 × 5 = 2 × 2 × 2 × 3 × 5, and 2 + 2 + 2 + 3 + 5 = 14.
# So the sum of the terms in the prime factorisation of ^(10)C_(3) is 14.
# 
# Find the sum of the terms in the prime factorisation of ^(20000000)C_(15000000).

require 'common'

#counts the number of times p appears in the factorization of n!
def appearences_in_factorial(p,n)
    sum = 0
    while n > 0
	n /= p
	sum += n
    end
    sum
end
    
def compute_for(n,k)
    $Primes.reject{|p| p > n}.inject(0){|sum, p| sum + p*(appearences_in_factorial(p,n) - appearences_in_factorial(p,k) - appearences_in_factorial(p,n-k))}
end

puts compute_for(20000000,15000000)