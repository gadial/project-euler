# There are 1111 ways in which five 6-sided dice (sides numbered 1 to 6) can be rolled so that the top three sum to 15. Some examples are:
# 
# D_(1),D_(2),D_(3),D_(4),D_(5) = 4,3,6,3,5
# D_(1),D_(2),D_(3),D_(4),D_(5) = 4,3,3,5,6
# D_(1),D_(2),D_(3),D_(4),D_(5) = 3,3,3,6,6
# D_(1),D_(2),D_(3),D_(4),D_(5) = 6,6,3,3,3
# 
# In how many ways can twenty 12-sided dice (sides numbered 1 to 12) be rolled so that the top ten sum to 70?
require 'common'

$Values = {}
def f(goal, remaining_cubes, min_value, max_value)
    return $Values[[goal,remaining_cubes,min_value,max_value]] if $Values[[goal,remaining_cubes,min_value,max_value]]
    return 0 if goal < 0
    return 1 if goal == 0 and remaining_cubes == 0
    return 0 if goal > 0 and remaining_cubes == 0

    result = (min_value..max_value).collect{|val| f(goal-val, remaining_cubes-1,min_value,max_value)}.sum
    
    $Values[[goal,remaining_cubes,min_value,max_value]] = result
    return result
end

def generate_triplets(max, max_size_of_first_element)
    #the second element must be at least 1, but first and third can be 0
    #the sum of the first and second elements must exceed max_size_of_first_element
    result = []
    (0..max_size_of_first_element).each do |first|
	(1..max - first).each do |second|
	    result << [first,second, max - first - second] if first+second > max_size_of_first_element
	end
    end
    return result
end

def solve(goal, number_of_cubes, max_value, high_value_holders)
    min_value = 1 #assumed

    triplets = generate_triplets(number_of_cubes,high_value_holders-1)
    result = triplets.collect do |triplet|
	(min_value..max_value).collect do |medium_value| 
	    f(goal-medium_value*(high_value_holders-triplet[0]),triplet[0],medium_value+1,max_value)*((medium_value-min_value)**triplet[2])*choose(number_of_cubes,triplet[0])*choose(number_of_cubes-triplet[0],triplet[1])
	end.sum
    end.sum
    
    return result
end

puts solve(70,20,12,10)