# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
# 
# Find the sum of all numbers which are equal to the sum of the factorial of their digits.
# 
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

#upper limit: 10**(n+1)-1, where n*9! is smaller than 10**(n+1)
#9!=362880
#easy to find that it suffices to check only numbers smaller than 2,540,160 (sum of factorials of 9,999,999)
require 'common'

$Factorials=(0..9).collect{|d| d.factorial}

def sum_of_factorials(number)
	number.digits.collect{|x| $Factorials[x]}.sum
end

puts (3..2540160).reject{|x| not x==sum_of_factorials(x)}.sum
