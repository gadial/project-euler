# The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
# 
# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
# 
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
require 'miller-rabin'
require 'common'

class Integer
	def each_prefix
		self.to_s.length.times do |i|
			yield(self.to_s[0..i].to_i)
		end
	end

	def each_suffix
		self.to_s.length.times do |i|
			yield(self.to_s[-(i+1)..-1].to_i)
		end
	end

	def suffix_prefix_prime?
		each_prefix{|x| return false if not x.prime?}
		each_suffix{|x| return false if not x.prime?}
		return true
	end
end

result = []
current = 23

while result.length < 11
	result << current if current.suffix_prefix_prime?
	current += 1
end

puts result.sum
