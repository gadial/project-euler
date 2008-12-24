# Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.
# 
# If we list the set of reduced proper fractions for d 8 in ascending order of size, we get:
# 
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# 
# It can be seen that there are 21 elements in this set.
# 
# How many elements would be contained in the set of reduced proper fractions for d 1,000,000?
require 'common'
require 'miller-rabin'


class Integer
	def totient
		prime_divisors.uniq.inject(self.to_f){|prod, p| prod * (1-(1.to_f / p))}.to_i
	end
end

max = 10**6

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
puts totient[2..max].sum
