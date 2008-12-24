# The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:
# 
# 1! + 4! + 5! = 1 + 24 + 120 = 145
# 
# Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:
# 
# 169 363601 1454 169
# 871 45361 871
# 872 45362 872
# 
# It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,
# 
# 69 363600 1454 169 363601 ( 1454)
# 78 45360 871 45361 ( 871)
# 540 145 ( 145)
# 
# Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.
# 
# How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?
require 'common'
$ChainLengths=[]
$ChainLengths[169]=3
$ChainLengths[1454]=3
$ChainLengths[363601]=3
$ChainLengths[871]=2
$ChainLengths[45361]=3
$ChainLengths[872]=2
$ChainLengths[45362]=3

class Integer
	def factorial_next
		digits.collect{|d| d.factorial}.sum
	end
	def chain_length
		current = self
		length = 0
		while $ChainLengths[current] == nil
			last = current
			current = current.factorial_next
			if current == last
				$ChainLengths[self] = length
				return length
			end
			length += 1
		end
		$ChainLengths[self] = length + $ChainLengths[current]
		return $ChainLengths[self]
	end
end
max = 10**6
puts (1..max).find_all{|n| puts(100*n.to_f / max); n.chain_length==60}.length
# puts 69.chain_length
