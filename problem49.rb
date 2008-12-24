# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.
# 
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.
# 
# What 12-digit number do you form by concatenating the three terms in this sequence?

require 'miller-rabin'
require 'common'
class Array
	def same_elements?(other)
		self.sort == other.sort
	end
	def each_triplet
		length.times{|i| (0..i-1).each {|j| (0..j-1).each {|k| yield(self[i],self[j],self[k])}}}
	end
	def arithmetic_sequence?
		return true if length < 2
		result = true
		d = self[1]-self[0]
		(2...length).each{|i| result = false unless d == self[i]-self[i-1]}
		return result
	end
end

class Integer
	def distinct_digits?
		self.digits.length == self.digits.uniq.length
	end
	def same_digits?(other)
		self.digits.same_elements?(other.digits)
	end
end

base = (1111..9999).reject{|x| not x.prime?}

while not base.empty?
	first = base.first
	candidates = base.find_all{|x| first.same_digits?(x)}.sort
	candidates.each_triplet{|a,b,c| puts "a=#{a}, b=#{b}, c=#{c}" if [c,b,a].arithmetic_sequence?}
	base -= candidates
end