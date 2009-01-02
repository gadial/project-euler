# By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 362. What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number: 9216 = 962. We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted, neither may a different letter have the same digital value as another letter.
# 
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).
# 
# What is the largest square number formed by any member of such a pair?
# 
# NOTE: All anagrams formed must be contained in the given text file.
require 'common'
# $Perms = (0..9).to_a.all_choices_without_repetitions(7)

class String
	def letters
		split("").uniq.sort
	end
	def to_num(dict)
	    split("").collect{|l| dict[l]}.join("").to_i
	end
	def replacement_is_ok?(dict)
	    dict[self[0..0]] != 0
	end
	def anagram?(rhs)
	    self.split("").sort == rhs.split("").sort
	end
end

def find_max_for_pair(a,b)
    max = 0
    letters = a.letters
    (0..9).to_a.all_choices_without_repetitions(letters.length).each do |r|
	dict = {}
	r.each_index{|i| dict[letters[i]] = r[i]}
	if a.replacement_is_ok?(dict) and b.replacement_is_ok?(dict) 
	    x = a.to_num(dict)
	    y = b.to_num(dict)
	    max = [x,y,max].max if x.square? and y.square?
	end
    end
    return max
end

# words = File.open("words.txt", "r"){|file| file.read.split(",").collect{|s| s.delete("\"")}}

# anagrams = []
# while not words.empty?
#     puts words.length
#     temp_word = words.shift
#     matches = words.find_all{|word| temp_word.anagram?(word)}
#     anagrams += matches.collect{|word| [temp_word, word]}
# end
# 
# puts anagrams.inspect

anagarms = [["ACT", "CAT"], ["ARISE", "RAISE"], ["BOARD", "BROAD"], ["CARE", "RACE"], ["CENTRE", "RECENT"], ["COURSE", "SOURCE"], ["CREATION", "REACTION"], ["CREDIT", "DIRECT"], ["DANGER", "GARDEN"], ["DEAL", "LEAD"], ["DOG", "GOD"], ["EARN", "NEAR"], ["EARTH", "HEART"], ["EAST", "SEAT"], ["EAT", "TEA"], ["EXCEPT", "EXPECT"], ["FILE", "LIFE"], ["FORM", "FROM"], ["FORMER", "REFORM"], ["HATE", "HEAT"], ["HOW", "WHO"], ["IGNORE", "REGION"], ["INTRODUCE", "REDUCTION"], ["ITEM", "TIME"], ["ITS", "SIT"], ["LEAST", "STEAL"], ["MALE", "MEAL"], ["MEAN", "NAME"], ["NIGHT", "THING"], ["NO", "ON"], ["NOTE", "TONE"], ["NOW", "OWN"], ["PHASE", "SHAPE"], ["POST", "SPOT"], ["POST", "STOP"], ["QUIET", "QUITE"], ["RATE", "TEAR"], ["SHEET", "THESE"], ["SHOUT", "SOUTH"], ["SHUT", "THUS"], ["SIGN", "SING"], ["SPOT", "STOP"], ["SURE", "USER"], ["THROW", "WORTH"]]
# puts anagarms.length

# puts anagarms.collect{|pair| puts pair.inspect; t = find_max_for_pair(pair.first, pair.last); puts t; t}.max
puts anagarms.collect{|pair| puts pair.inspect; find_max_for_pair(pair.first, pair.last)}.max