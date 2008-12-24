# The first two consecutive numbers to have two distinct prime factors are:
# 
# 14 = 2 7
# 15 = 3 5
# 
# The first three consecutive numbers to have three distinct prime factors are:
# 
# 644 = 2² 7 23
# 645 = 3 5 43
# 646 = 2 17 19.
# 
# Find the first four consecutive integers to have four distinct primes factors. What is the first of these numbers?


class Integer
	def first_divisor
		(2..self).each {|i| return i if self % i == 0} 
	end
	
	def prime_factors
		return [] if (self == 1 or self == 0)
		factors = []
		factors << self.first_divisor
		factors += (self / factors.first).prime_factors
		return factors
	end
	def distinct_prime_factors
		prime_factors.uniq
	end
end

number = 4
current = 68817
consecutive = 0
while consecutive < number
	if current.distinct_prime_factors.size >= number
		consecutive +=1
		puts "success with #{current}. Consecutive: #{consecutive}" if consecutive > 1
	else
		consecutive = 0
	end
	current += 1
end

puts current - number