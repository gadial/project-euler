# The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
# 
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
# 
#     * d2d3d4=406 is divisible by 2
#     * d3d4d5=063 is divisible by 3
#     * d4d5d6=635 is divisible by 5
#     * d5d6d7=357 is divisible by 7
#     * d6d7d8=572 is divisible by 11
#     * d7d8d9=728 is divisible by 13
#     * d8d9d10=289 is divisible by 17
# 
# Find the sum of all 0 to 9 pandigital numbers with this property.

require 'common'
class Integer
	def has_the_property?(upto=7)
		divisors=[17,13,11,7,5,3,2,1]
		current = self % 1000
		temp = self / 1000
		upto.times do |i|
			return false unless current % divisors[i] == 0
			current = (current / 10) + (100*(temp % 10))
			temp = temp / 10
		end
		return true
	end
	def pandigital?
		digits.uniq.length == digits.length
	end
	def left_pandigitals
		(0..9).collect{|i| self + i*(10**(digits.length))}.reject{|x| not x.pandigital?}
	end
	def to_string(base=10, minimum_digits=0)
		s=self.to_s(base)
		while s.length < minimum_digits
			s = "0" + s
		end
		s
	end
end

class String
	def left_pandigitals
		(0..9).collect{|i| i.to_s + self}.reject{|x| not x.pandigital?}
	end
	def pandigital?
		self.length == self.split("").uniq.length
	end
end

base=(1..100).collect{|x| x*17}.reject{|x| x>999 or not x.pandigital?}.collect{|x| x.to_string(10,3)}

(2..8).each do |i|
	base = base.collect{|x| x.left_pandigitals.reject{|y| not y.to_i.has_the_property?(i)}}.flatten
end


puts base.collect{|x| x.to_i}.sum

