# The Fibonacci sequence is defined by the recurrence relation:
# 
#     F_(n) = F_(n−1) + F_(n−2), where F_(1) = 1 and F_(2) = 1.
# 
# It turns out that F_(541), which contains 113 digits, is the first Fibonacci number for which the last nine digits are 1-9 pandigital (contain all the digits 1 to 9, but not necessarily in order). And F_(2749), which contains 575 digits, is the first Fibonacci number for which the first nine digits are 1-9 pandigital.
# 
# Given that F_(k) is the first Fibonacci number for which the first nine digits AND the last nine digits are 1-9 pandigital, find k.
require 'common'
class Integer
    def first_pandigital?
    	digits[0..8].sort == (1..9).to_a
    end
    def last_pandigital?
	digits.length >= 9 and digits[-9..-1].sort == (1..9).to_a
    end
end

def each_fibonacci
	x = 1
	y = 1
	n = 3
	yield(x,1)
	yield(y,2)
	while true
		x, y = y, x+y
		yield(y,n)
		n += 1
	end
end

each_fibonacci {|f,n| puts n; break if f.first_pandigital? and f.last_pandigital?}