# Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
# The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.
# 
# Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.
# 
# Find the value of n, 1 n 107, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.
require 'common'
require 'miller-rabin'
class Integer
# 	def totient
# 		prime_divisors.uniq.inject(self.to_f){|prod, p| prod * (1-(1.to_f / p))}.to_i
# 	end
	def is_permutation_of?(other)
		digits.sort == other.digits.sort
	end
end

max = 10**7

totient=(0..max).to_a
$Primes.each_index do |i|
	puts 100*i.to_f / $Primes.length
	temp = $Primes[i]
	while temp <= max
		totient[temp]*=(1-(1.to_f / $Primes[i]))
		temp += $Primes[i]
	end
end

totient.collect!{|x| x.to_i}

puts (2...max).collect{|x| puts(100*x.to_f / max); [x,totient[x]]}.find_all{|a| a[0].is_permutation_of?(a[1])}.collect{|a| a+[a[0].to_f / a[1]]}.min{|a,b| a[2] <=> b[2]}.inspect
