# The number 512 is interesting because it is equal to the sum of its digits raised to some power: 5 + 1 + 2 = 8, and 8^(3) = 512. Another example of a number with this property is 614656 = 28^(4).
# 
# We shall define a_(n) to be the nth term of this sequence and insist that a number must contain at least two digits to have a sum.
# 
# You are given that a_(2) = 512 and a_(10) = 614656.
# 
# Find a_(30).

#We consider only numbers of the form a^k. Clearly we can bound k - if a^k has a digits
require 'common'
def all_pairs(max_x, max_y)
	results = []
	(1..max_x).each {|x| (1..max_y).each {|y| results << [x,y]}}
	results
end

def pair_interesting(a,k)
    k > 1 and a > 1 and a == (a**k).sum_of_digits
end

max = 80

puts all_pairs(max,max).find_all{|pair| pair_interesting(pair.first, pair.last)}.collect{|pair| pair.first**pair.last}.sort[29]