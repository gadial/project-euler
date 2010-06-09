# For a positive integer n, let σ2(n) be the sum of the squares of its divisors. For example,
# σ2(10) = 1 + 4 + 25 + 100 = 130.
# 
# Find the sum of all n, 0 n 64,000,000 such that σ2(n) is a perfect square.

#easy to see that σ2(ab)=σ2(a)σ2(b) for gcd(a,b)=1
#and σ2(p^k) = ((p^2)^(k+1)-1) / (p^2-1)
require 'common'
class Integer
	def s2
		uniq_divisors.collect{|x| x**2}.sum
	end
end

p1 = 10
p2 = 13
puts p1.s2
puts p2.s2
puts (p1*p2).s2
# puts (1..10000).find_all{|x| x.s2.square?}.collect{|x| [x,x.s2,x.uniq_divisors.inspect]}.inspect