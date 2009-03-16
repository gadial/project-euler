# A number consisting entirely of ones is called a repunit. We shall define R(k) to be a repunit of length k; for example, R(6) = 111111.
# 
# Let us consider repunits of the form R(10^(n)).
# 
# Although R(10), R(100), or R(1000) are not divisible by 17, R(10000) is divisible by 17. Yet there is no value of n for which R(10^(n)) will divide by 19. In fact, it is remarkable that 11, 17, 41, and 73 are only four primes below one-hundred that can ever be a factor of R(10^(n)).
# 
# Find the sum of all the primes below one-hundred thousand that will never be a factor of R(10^(n)).
require 'common'

def a(n)
	return nil if n % 2 == 0 or n % 5 == 0
	count = 1
	current = 1
	while current != 0
		count += 1
		current = (current * 10 + 1) % n
	end
	return count
end

def will_divide_some_power_of_ten(n)
	#n divides some power of ten iff its only factors are 2 and 5
	while n % 5 == 0
		n /= 5
	end
	while n % 2 ==0
		n /= 2
	end
	return n == 1
end

max = 100000
puts sieve_primes(max).find_all{|p| puts p; p == 2 or p == 5 or not will_divide_some_power_of_ten(a(p))}.sum
