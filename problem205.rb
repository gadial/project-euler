# Peter has nine four-sided (pyramidal) dice, each with faces numbered 1, 2, 3, 4.
# Colin has six six-sided (cubic) dice, each with faces numbered 1, 2, 3, 4, 5, 6.
# 
# Peter and Colin roll their dice and compare totals: the highest total wins. The result is a draw if the totals are equal.
# 
# What is the probability that Pyramidal Pete beats Cubic Colin? Give your answer rounded to seven decimal places in the form 0.abcdefg
require 'common'
class Array
	def normalize
		collect {|x| x.to_f / sum}
	end
end

def count_values(dice_number, dice_sides)
	def recurse(dice_number, dice_sides, current_value, values)
		if dice_number == 0
			values[current_value] += 1
		else
			dice_sides.times {|i| recurse(dice_number-1, dice_sides,current_value+(i+1),values)}
		end
	end
	values = [0]*(dice_number*dice_sides+1)
	recurse(dice_number,dice_sides,0,values)
	return values
end

def prob_to_score_less_than(prob_vector, n)
	prob_vector[0...n].sum
end

def prob_pete_wins(pete_prob, colin_prob)
	total_prob = 0
	pete_prob.each_index do |n|
		total_prob += pete_prob[n]*prob_to_score_less_than(colin_prob,n)
	end
	total_prob
end

pete_prob = count_values(9,4).normalize
colin_prob = count_values(6,6).normalize
puts prob_pete_wins(pete_prob,colin_prob)