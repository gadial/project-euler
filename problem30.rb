# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
# 
#     1634 = 14 + 64 + 34 + 44
#     8208 = 84 + 24 + 04 + 84
#     9474 = 94 + 44 + 74 + 44
# 
# As 1 = 14 is not a sum it is not included.
# 
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# 
# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

#since each digit is less than 10 and so the sum cannot exceed n*(10**n), we only need to check numbers in that range
require 'common'
class Integer
	def is_sum_of_powers_of_digits?(n)
		digits = self.to_s.split("")
		return false if digits.length == 1 #by definition
		self == digits.collect{|s| (s.to_i)**n}.sum
	end
end
n=5

max=n*(10**n)

puts (1..max).to_a.find_all{|x| x.is_sum_of_powers_of_digits?(n)}.sum

