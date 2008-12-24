# A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:
# 
#     1/2	= 	0.5
#     1/3	= 	0.(3)
#     1/4	= 	0.25
#     1/5	= 	0.2
#     1/6	= 	0.1(6)
#     1/7	= 	0.(142857)
#     1/8	= 	0.125
#     1/9	= 	0.(1)
#     1/10	= 	0.1
# 
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.
# 
# Find the value of d 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
require 'common'

class Integer
	def reciprocal
		result = []
		current = [10]
		i=0
		while true
			result << current[i] / self
			temp = (current[i] % self) * 10
			if current.include?(temp)
				index = current.index(temp)
				result.insert(index, "(")
				result << ")"
				break
			end
			current[i+1] = temp
			break if current[i+1] == 0
			i += 1
		end
		return "0."+result.join("")
	end
end

def length_of_cycle(s)
	result = 0
	s.scan(/\(\d*\)/){|rep| result = rep.length-2}
	return result
end

puts (2..1000).collect{|x| [x,length_of_cycle(x.reciprocal)]}.max{|a,b| a[1] <=> b[1]}[0]
