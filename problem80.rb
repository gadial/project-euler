# It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.
# 
# The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.
# 
# For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.

#wikipedia's algorithm:

#    1. Starting on the left, bring down the most significant (leftmost) pair of digits not yet used (if all the digits have been used, write "00") and write them to the right of the remainder from the previous step (on the first step, there will be no remainder). In other words, multiply the remainder by 100 and add the two digits. This will be the current value c.
#    2. Find p, y and x, as follows:
#           * Let p be the part of the root found so far, ignoring any decimal point. (For the first step, p = 0).
#           * Let y equal (20 \cdot p + x) \cdot x.
#           * Determine the greatest digit x such that (20 \cdot p + x) \cdot x (that is, y) does not exceed c.
#                 o Note: 20p + x is simply twice p, with the digit x appended to the right).
#                 o Note: You can find x by guessing what c/(20·p) is and doing a trial calculation of y, then adjusting x upward or downward as necessary.
#           * Place the digit x as the next digit of the root, i.e above the two digits of the square which you just brought down. Thus the next p will be the old p times 10 plus x.
#    3. Subtract y from c to form a new remainder.
#    4. If the remainder is zero and there are no more digits to bring down, then the algorithm has terminated. Otherwise go back to step 1 for another iteration.

require 'common'
class Integer
	def compute_digit_pairs
		result = []
		temp = self
		while temp>0
			result.unshift(temp % 100)
			temp /= 100
		end
		result
	end
	def long_sqrt(length=110)
		digit_pairs = compute_digit_pairs
		p = 0
		remainder = 0
		while ((remainder != 0 or not digit_pairs.empty?) and p.digits.length <= length)
			next_pair = (digit_pairs.empty?)?(0):(digit_pairs.shift)
			c=remainder*100 + next_pair
# 			puts "begin: c=#{c}, p=#{p}, next_pair=#{next_pair}, remainder=#{remainder}"
			final_x = (0..9).find_all{|x| (20*p+x)*x <= c}.max
			y = (20*p+final_x)*final_x
# 			puts (0..9).find_all{|x| (20*p+x)*x <= c}.inspect
			p = 10*p + final_x
			remainder = c - y
# 			puts "end: c=#{c}, p=#{p}, final_x=#{final_x}, next_pair=#{next_pair}, remainder=#{remainder}"
# 			gets
		end
		p
	end
	def square?
		(sqrt.to_i)**2 == self
	end
end

puts (2..99).reject{|x| x.square?}.collect{|x| puts x; x.long_sqrt.digits[0..99].sum}.sum
