# The cube, 41063625 (3453), can be permuted to produce two other cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.
# 
# Find the smallest cube for which exactly five permutations of its digits are cube.
require 'common'
class Integer
	def exact_digits
		digits.uniq.collect{|x| [x,digits.find_all{|y| y==x}.size]}.sort
	end
end


max = 10000
cubes = (1..max).collect{|x| x**3}
# puts cubes.inspect
classes={}

cubes.each do |x|
	digits = x.exact_digits
	classes[digits]||=0
	classes[digits] += 1
end

keys = classes.find_all{|x| x[1]==5}.collect{|x| x[0]}
puts keys.collect{|key| cubes.find_all{|cube| cube.exact_digits == key}}.flatten.sort.first