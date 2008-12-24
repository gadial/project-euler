# A googol (10100) is a massive number: one followed by one-hundred zeros; 100100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.
# 
# Considering natural numbers of the form, a^b, where a, b 100, what is the maximum digital sum?

require 'common'
sums = []
(1..100).each do |a|
	(1..100).each do |b|
		sums << (a**b).digits.sum
	end
end

puts sums.max