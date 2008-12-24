# Some positive integers n have the property that the sum [ n + reverse(n) ] consists entirely of odd (decimal) digits. For instance, 36 + 63 = 99 and 409 + 904 = 1313. We will call such numbers reversible; so 36, 63, 409, and 904 are reversible. Leading zeroes are not allowed in either n or reverse(n).
# 
# There are 120 reversible numbers below one-thousand.
# 
# How many reversible numbers are there below one-billion (109)?
require 'common'
class Integer
	def reverse
		to_s.reverse.to_i
	end
	def all_digits_odd?
		digits.all_fulfill{|x| x.odd?}
	end
	def reversible?
		return false if (self % 10 == 0)
		(self+self.reverse).all_digits_odd?
	end
end

max = 10**3
puts (1...max).find_all{|x| x.reversible?}.length