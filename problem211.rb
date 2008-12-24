# For a positive integer n, let σ2(n) be the sum of the squares of its divisors. For example,
# σ2(10) = 1 + 4 + 25 + 100 = 130.
# 
# Find the sum of all n, 0 n 64,000,000 such that σ2(n) is a perfect square.
require 'common'
class Integer
	def s2
		uniq_divisors.collect{|x| x**2}.sum
	end
end

puts (1..10000).find_all{|x| x.s2.square?}.collect{|x| [x,x.s2,x.uniq_divisors.inspect]}.inspect