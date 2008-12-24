# By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, , *, /) and brackets/parentheses, it is possible to form different positive integer targets.
# 
# For example,
# 
# 8 = (4 * (1 + 3)) / 2
# 14 = 4 * (3 + 1 / 2)
# 19 = 4 * (2 + 3) 1
# 36 = 3 * 4 * (2 + 1)
# 
# Note that concatenations of the digits, like 12 + 34, are not allowed.
# 
# Using the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.
# 
# Find the set of four distinct digits, a b < c d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.
require 'common'
def compute(digits, perm, order, actions)
	result = []
	perm.each {|i| result << digits[i].to_f}
	places = order.dup
	temp_actions = actions.dup
	while not temp_actions.empty?
		next_action = temp_actions.shift
		next_place = places.shift
# 		puts result.inspect + " #{next_action}, #{next_place}"
		case next_action
			when :plus: result[next_place] += result[next_place+1]
			when :minus: result[next_place] -= result[next_place+1]
			when :multi: result[next_place] *= result[next_place+1]
			when :div: return nil if result[next_place+1] ==0; result[next_place] /= result[next_place+1]
		end
		result.delete_at(next_place+1)
		places.collect!{|x| ((x > next_place)?(x-1):(x))}
	end
	return ((result.first.to_i == result.first)?(result.first.to_i):(nil))
end

def nice_representation(digits, perm, order, actions)
	result = []
	perm.each {|i| result << digits[i].to_s}
	places = order.dup
	temp_actions = actions.dup
	while not temp_actions.empty?
		next_action = temp_actions.shift
		next_place = places.shift
		case next_action
			when :plus: op = "+"
			when :minus: op = "-"
			when :multi: op = "*"
			when :div: op = "/"
		end
		result[next_place] = "(#{result[next_place]}#{op}#{result[next_place+1]})"
		result.delete_at(next_place+1)
		places.collect!{|x| ((x > next_place)?(x-1):(x))}
	end
	return result.first
end

def make_numbers(digits)
	result = []
	(0..3).to_a.all_permutations.each do |p|
		(0..2).to_a.all_permutations.each do |o|
			[:plus, :minus, :multi, :div].all_choices_with_repetitions(3).each do |actions|
				result << compute(digits, p, o, actions)
# 				puts result.last.inspect + " " + nice_representation(digits,p,o,actions)
			end
		end
	end
	return result.compact.uniq.sort.reject{|x| x<1}
end

def how_to_make(target, digits)
	result = []
	(0..3).to_a.all_permutations.each do |p|
		(0..2).to_a.all_permutations.each do |o|
			[:plus, :minus, :multi, :div].all_choices_with_repetitions(3).each do |actions|
				result << compute(digits, p, o, actions)
 				return nice_representation(digits,p,o,actions) if result.last == target
			end
		end
	end
	return "cannot make"
end

class Array
	def consecutive_length
		len = 0
		while self[len] == len+1 and len < length
			len += 1
		end
		return len
	end
end

# digits = (1234..9999).collect{|d| d.digits.uniq.sort}.reject{|d| d.length < 4 or d.include?(0)}.uniq
# puts digits.collect{|d| t=[d, make_numbers(d).consecutive_length]; puts t.inspect; t}.max{|a,b| a[1] <=> b[1]}.inspect

puts how_to_make(67,[1,5,6,7])