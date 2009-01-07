# Consider the number 45656.
# It can be seen that each pair of consecutive digits of 45656 has a difference of one.
# A number for which every pair of consecutive digits has a difference of one is called a step number.
# A pandigital number contains every decimal digit from 0 to 9 at least once.
# How many pandigital step numbers less than 10^(40) are there?

#a standard transfer-matrix algorithm

#we keep listing of items of the form [current, max, min]. In the end we accept only items where min=0 and max=9

steps = 40
total = 0
values = {}
(1..9).each{|n| values[[n,n,n]]=1}
(steps-1).times do
    new_values = {}
    values.each do |key, value|
	if key.first > 0
	    temp_key = [key[0]-1,[key[0]-1,key[1]].min,key[2]]
	    new_values[temp_key] ||= 0
	    new_values[temp_key] += value
	end
	
	if key.first < 9
	    temp_key = [key[0]+1,key[1],[key[0]+1,key[2]].max]
	    new_values[temp_key] ||= 0
	    new_values[temp_key] += value
	end
	
	total += value if key[1] == 0 and key[2] == 9
# 	puts "key=#{key.inspect}, value = #{value}"
    end
    values = new_values
end

values.each {|key, value| total += value if key[1] == 0 and key[2] == 9}
puts total
