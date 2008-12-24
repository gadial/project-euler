require 'common'
require 'miller-rabin'
class Integer
	def totient
		prime_divisors.uniq.inject(self.to_f){|prod, p| prod * (1-(1.to_f / p))}.to_i
	end
	def is_permutation_of?(other)
		digits.sort == other.digits.sort
	end
end

puts 18 / 18.totient
puts 6 / 6.totient