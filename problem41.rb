# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
# 
# What is the largest n-digit pandigital prime that exists?

#1+2+3+4+5+6+7+8+9=45 which is divisible by 3, so no 9-pandigital prime exists

require 'miller-rabin'

def all_permutations_of(array)
	return [[]] if array.empty?
	array.sort.inject([]){|sum,x| sum += all_permutations_of(array-[x]).collect{|p| p.unshift(x)}}
end


results = []
(1..8).each do |n|
	all_permutations_of((1..n).to_a).each do |p|
		t=p.join("").to_i
		results << t if t.prime?
	end
end

puts results.max