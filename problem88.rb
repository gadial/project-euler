# A natural number, N, that can be written as the sum and product of a given set of at least two natural numbers, {a1, a2, ... , ak} is called a product-sum number: N = a1 + a2 + ... + ak = a1  a2  ...  ak.
# 
# For example, 6 = 1 + 2 + 3 = 1 2 3.
# 
# For a given set of size, k, we shall call the smallest N with this property a minimal product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6 are as follows.
# 
# k=2: 4 = 2 2 = 2 + 2
# k=3: 6 = 1 2 3 = 1 + 2 + 3
# k=4: 8 = 1 1 2 4 = 1 + 1 + 2 + 4
# k=5: 8 = 1 1 2 2 2 = 1 + 1 + 2 + 2 + 2
# k=6: 12 = 1 1 1 1 2 6 = 1 + 1 + 1 + 1 + 2 + 6
# 
# Hence for 2k6, the sum of all the minimal product-sum numbers is 4+6+8+12 = 30; note that 8 is only counted once in the sum.
# 
# In fact, as the complete set of minimal product-sum numbers for 2k12 is {4, 6, 8, 12, 15, 16}, the sum is 61.
# 
# What is the sum of all the minimal product-sum numbers for 2k12000?
$TwoSplits=[]
$AllSplits=[]
require 'common'
class Array
	def direct_product(other)
		result = []
		each {|x| other.each {|y| result << x+y}}
		return result
	end
end
class Integer
	def all_2_splits
		return $TwoSplits[self] unless $TwoSplits[self] == nil
		result = []
		current = 2
		while current ** 2 <= self
			result << [current, self / current] if self % current == 0
			current += 1
		end
		$TwoSplits[self] = result
		return result
	end
	def all_splits
		return $AllSplits[self] unless $AllSplits[self] == nil
		result = [[self]]
		all_2_splits.each do |split|
			result += split.first.all_splits.direct_product(split.last.all_splits)
		end
		result.uniq!
		$AllSplits[self] = result
		return result
	end
	def good_for_k
		all_splits.collect{|split| split.prod-split.sum+split.length}.uniq
	end
end

max = 12000
sum = 0
current = 2
remaining_k = (2..max).to_a
while not remaining_k.empty?
	puts current
	new_k = current.good_for_k
	sum += current unless (new_k & remaining_k).empty?
	remaining_k -= new_k
	current += 1
end
puts sum
