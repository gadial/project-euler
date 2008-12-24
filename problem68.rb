# Consider the following "magic" 3-gon ring, filled with the numbers 1 to 6, and each line adding to nine.
# 
# Working clockwise, and starting from the group of three with the numerically lowest external node (4,3,2 in this example), each solution can be described uniquely. For example, the above solution can be described by the set: 4,3,2; 6,2,1; 5,1,3.
# 
# It is possible to complete the ring with four different totals: 9, 10, 11, and 12. There are eight solutions in total.
# Total	Solution Set
# 9	4,2,3; 5,3,1; 6,1,2
# 9	4,3,2; 6,2,1; 5,1,3
# 10	2,3,5; 4,5,1; 6,1,3
# 10	2,5,3; 6,3,1; 4,1,5
# 11	1,4,6; 3,6,2; 5,2,4
# 11	1,6,4; 5,4,2; 3,2,6
# 12	1,5,6; 2,6,4; 3,4,5
# 12	1,6,5; 3,5,4; 2,4,6
# 
# By concatenating each group it is possible to form 9-digit strings; the maximum string for a 3-gon ring is 432621513.
# 
# Using the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings. What is the maximum 16-digit string for a "magic" 5-gon ring?

#we want all distinct five-digit, base-11 numbers
#canonize by choosing only numbers whose first digit is the smallest
require 'common'
min = "12345".to_i(11)
max = "a9876".to_i(11)

cycles = (min..max).reject{|x| d=x.digits(11); d.uniq.length < 5 or d.first != d.min}.collect{|x| x.digits(11)}
results = []
cycles.each do |cycle|
	remaining_numbers = [1,2,3,4,5,6,7,8,9,10] - cycle
	remaining_numbers.all_permutations.each do |p|
		exp_outcome = p.last + cycle.last + cycle.first
		results << [cycle,p] if p[0]+cycle[0]+cycle[1] == exp_outcome and 
					p[1]+cycle[1]+cycle[2] == exp_outcome and 
					p[2]+cycle[2]+cycle[3] == exp_outcome and 
					p[3]+cycle[3]+cycle[4] == exp_outcome
	end
end

results.collect! do |result|
	cycle = result.first.collect{|x| x.to_s}
	p = result.last.collect{|x| x.to_s}
	s=""
	start = result.last.index(result.last.min)
  	cycle.each_index{|i| s+= (p[(i+start) % 5] + cycle[(i+start) % 5] + cycle[(i+1+start) % 5])}
	s
end

puts results.reject{|s| s.length == 17}.collect{|s| s.to_i}.max