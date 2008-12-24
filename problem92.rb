# A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

# For example,

# 44 32 13 10 1 1
# 85 89 145 42 20 4 16 37 58 89

# Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

# How many starting numbers below ten million will arrive at 89?

#max sum of squares for a 7-digit number: 7*9^2<600
require 'common'
class Integer
	def sum_of_digit_squares
		digits.collect{|x| x*x}.sum
	end
end

max = 10**7

results = [0,1]
results[89]=89
(2..600).each do |x|
	temp = x
	while temp != 89 and temp != 1
		temp = temp.sum_of_digit_squares
	end
	results[x]=temp
end

puts results.inspect

puts (2..max).find_all{|x| puts(100*x.to_f / max); results[x.sum_of_digit_squares]==89}.length