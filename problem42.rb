# The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:
# 
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
# 
# By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.
# 
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?

require 'common'
def triangle_numbers(upto)
	(1..upto).collect{|n| (n*(n+1)) / 2}
end

class String
	def value
		split("").collect{|c| 1+c[0]-"A"[0]}.sum
	end
end
# puts triangle_numbers(50).inspect
words = File.open("words.txt","r"){|file| file.read.delete("\"").split(",")}
word_values = words.collect{|word| word.value}
max_value=word_values.max
triangles = triangle_numbers(max_value)
puts word_values.reject{|x| not triangles.include?(x)}.length
