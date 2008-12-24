# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a b, then a and b are an amicable pair and each of a and b are called amicable numbers.

# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.
require 'common'
class Integer
	def larger_amicable
		x = proper_divisors.sum
		return nil unless x > self
		return nil unless x.proper_divisors.sum == self
		return x
	end
end

puts (1...10000).collect {|x| [x,x.larger_amicable]}.reject{|pair| pair[1] == nil or pair[1] >= 10000}.flatten.sum