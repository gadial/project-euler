# The product 7254 is unusual, as the identity, 39  186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

#a product of k and t digit numbers can give at most k+t digit number (or a k+t-1 digit number)
#so we must have k+d+(k+d)=9 or k+d+(k+d-1)=9. 
#The first is impossible.
#The second gives k+d=5.
#Hence: take all permutations. From them take all [1,4,4] and [2,3,4] pairs and check them
require 'common'

def all_permutations_of(array)
	return [[]] if array.empty?
	array.sort.inject([]){|sum,x| sum += all_permutations_of(array-[x]).collect{|p| p.unshift(x)}}
end

results = []
permutations = all_permutations_of((1..9).to_a)
permutations.each do |p|
	multiplicand=p.values_at(5..8).join("").to_i
	multiplier1=p.values_at(0..0).join("").to_i
	multiplier2=p.values_at(1..4).join("").to_i
	results << multiplicand if (multiplicand==multiplier1*multiplier2)
	
	multiplier1=p.values_at(0..1).join("").to_i
	multiplier2=p.values_at(2..4).join("").to_i
	results << multiplicand if (multiplicand==multiplier1*multiplier2)
end

puts results.uniq.sum