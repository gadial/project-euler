# The prime factors of 13195 are 5, 7, 13 and 29.
# 
# What is the largest prime factor of the number 600851475143 ?

def first_divisor(num)
	(2..num).each {|i| return i if num % i == 0} 
end

def ultra_naive_factor(num)
	return [] if (num == 1 or num == 0)
	factors = []
	factors << first_divisor(num)
	factors += ultra_naive_factor(num / factors.first)
	return factors
end

puts ultra_naive_factor(600851475143).sort.last