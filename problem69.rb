# Euler's Totient function, ?(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, ?(9)=6.
# n 	Relatively Prime 	?(n) 	n/?(n)
# 2 	1 	1 	2
# 3 	1,2 	2 	1.5
# 4 	1,3 	2 	2
# 5 	1,2,3,4 	4 	1.25
# 6 	1,5 	2 	3
# 7 	1,2,3,4,5,6 	6 	1.1666...
# 8 	1,3,5,7 	4 	2
# 9 	1,2,4,5,7,8 	6 	1.5
# 10 	1,3,7,9 	4 	2.5

# It can be seen that n=6 produces a maximum n/?(n) for n 10.

# Find the value of n 1,000,000 for which n/?(n) is a maximum.

#phi(n)=n*prod_{p|n}(1-1/p)
#therefore, maximize 1/prod(-1/p)
#therefore, minimize prod(1-1/p)
require 'common'
require 'miller-rabin'
class Integer
	def totient
		prime_divisors.uniq.inject(self.to_f){|prod, p| prod * (1-(1.to_f / p))}.to_i
	end
end

prod = 1
current = 2
primes = []
while not prod > 10**6
	if current.prime?
		primes << current
		prod *= current
	end
	current += 1
end
primes.pop

puts primes.inject{|prod, p| prod*p}
# puts (temp..10**6).collect{|n| puts(100*n.to_f / 10**6); [n,n.to_f / n.totient]}.max{|a,b| a[1] <=> b[1]}.inspect
