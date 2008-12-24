# By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 362. What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number: 9216 = 962. We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted, neither may a different letter have the same digital value as another letter.
# 
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).
# 
# What is the largest square number formed by any member of such a pair?
# 
# NOTE: All anagrams formed must be contained in the given text file.
require 'common'

class String
	def letters
		split("").uniq.sort
	end
	def replace_by(source, destination)
		raise "source length != destination length" if source.length != destination.length
		
	end
end

# words = File.open("words.txt", "r"){|file| file.read.split(",").collect{|s| s.delete("\"")}}
# 
# pairs = []
# 
# words.each_index do |i|
# 	puts i
# 	for j in (i+1...words.length)
# 		pairs << [words[i], words[j]] if words[i].letters == words[j].letters
# 	end
# end
# 
# puts pairs.inspect
# puts words.sort{|a,b| a.length <=> b.length}.inspect
def good_anagrams_for(pair)
	letters = pair.first.letters
	
	choices = (0..9).to_a.all_choices_without_repetitions
end

interesting_pairs = [["ABILITY", "LIABILITY"], ["ACCESS", "CASE"], ["ACCIDENT", "CANDIDATE"], ["ACCIDENT", "INDICATE"], ["ACCOMPANY", "COMPANY"], ["ACT", "CAT"], ["ACTION", "CONTAIN"], ["AFFAIR", "FAIR"], ["AGAIN", "GAIN"], ["AGREEMENT", "ARRANGEMENT"], ["AHEAD", "HEAD"], ["AIRCRAFT", "TRAFFIC"], ["APART", "PART"], ["APPARENT", "PARENT"], ["APPARENT", "PARTNER"], ["APPARENT", "PATTERN"], ["APPEAR", "PAPER"], ["APPEAR", "PREPARE"], ["APPLY", "PLAY"], ["AREA", "EAR"], ["AREA", "RARE"], ["ARISE", "RAISE"], ["ARMY", "MARRY"], ["ARRANGE", "RANGE"], ["ASSESS", "SEA"], ["ASSESSMENT", "STATEMENT"], ["ASSET", "EAST"], ["ASSET", "ESTATE"], ["ASSET", "SEAT"], ["ASSET", "STATE"], ["ATTACH", "CATCH"], ["AWARD", "DRAW"], ["AWARE", "WEAR"], ["AWAY", "WAY"], ["BATTLE", "TABLE"], ["BEGIN", "BEGINNING"], ["BOARD", "BROAD"], ["CANDIDATE", "INDICATE"], ["CARE", "CAREER"], ["CARE", "RACE"], ["CAREER", "RACE"], ["CENTRE", "RECENT"], ["CHARACTER", "TEACHER"], ["CLEAR", "RECALL"], ["COAL", "LOCAL"], ["COLLECTION", "ELECTION"], ["CONCENTRATION", "CREATION"], ["CONCENTRATION", "REACTION"], ["CONCERN", "CORNER"], ["CONNECT", "CONTENT"], ["CONNECTION", "NOTICE"], ["CONSERVATIVE", "CONVERSATION"], ["CONSTRUCTION", "INSTRUCTION"], ["COURSE", "RESOURCE"], ["COURSE", "SOURCE"], ["COVER", "RECOVER"], ["CREATION", "REACTION"], ["CREDIT", "DIRECT"], ["DANGER", "GARDEN"], ["DEAL", "LEAD"], ["DERIVE", "DRIVE"], ["DERIVE", "DRIVER"], ["DETAIL", "DETAILED"], ["DO", "ODD"], ["DOG", "GOD"], ["DOG", "GOOD"], ["DRIVE", "DRIVER"], ["EAR", "RARE"], ["EARLY", "REALLY"], ["EARN", "NEAR"], ["EARTH", "HEART"], ["EARTH", "RATHER"], ["EARTH", "THEATRE"], ["EARTH", "THREAT"], ["EAST", "ESTATE"], ["EAST", "SEAT"], ["EAST", "STATE"], ["EAT", "TEA"], ["ECONOMIC", "INCOME"], ["EITHER", "THEIR"], ["ELSE", "LESS"], ["ELSE", "SELL"], ["EMPLOY", "EMPLOYEE"], ["END", "NEED"], ["ENSURE", "NURSE"], ["ESCAPE", "SPACE"], ["ESTATE", "SEAT"], ["ESTATE", "STATE"], ["EVERY", "VERY"], ["EXCEPT", "EXPECT"], ["EXTENT", "NEXT"], ["FAST", "STAFF"], ["FILE", "LIFE"], ["FLOW", "FOLLOW"], ["FOR", "ROOF"], ["FORM", "FROM"], ["FORMER", "REFORM"], ["FREE", "REFER"], ["GOD", "GOOD"], ["GREAT", "TARGET"], ["GUEST", "SUGGEST"], ["HATE", "HEAT"], ["HEART", "RATHER"], ["HEART", "THEATRE"], ["HEART", "THREAT"], ["HER", "HERE"], ["HOT", "TOOTH"], ["HOW", "WHO"], ["HURT", "TRUTH"], ["IGNORE", "REGION"], ["IMAGINE", "MEANING"], ["INTERNATIONAL", "RELATION"], ["INTERPRETATION", "OPERATION"], ["INTO", "NOTION"], ["INTRODUCE", "REDUCTION"], ["ITEM", "TIME"], ["ITS", "SIT"], ["LATER", "LATTER"], ["LATER", "RELATE"], ["LATTER", "RELATE"], ["LAW", "WALL"], ["LEAST", "STEAL"], ["LESS", "SELL"], ["LET", "TELL"], ["LIST", "STILL"], ["LITTLE", "TITLE"], ["LOT", "TOOL"], ["MALE", "MEAL"], ["MEAN", "NAME"], ["MEMBER", "REMEMBER"], ["NIGHT", "THING"], ["NO", "ON"], ["NOISE", "SESSION"], ["NONE", "ONE"], ["NOT", "ONTO"], ["NOTE", "TONE"], ["NOTHING", "TONIGHT"], ["NOW", "OWN"], ["OF", "OFF"], ["OPPOSITION", "POSITION"], ["OPTION", "POINT"], ["OUGHT", "THOUGH"], ["OUGHT", "THOUGHT"], ["PAPER", "PREPARE"], ["PARENT", "PARTNER"], ["PARENT", "PATTERN"], ["PARTNER", "PATTERN"], ["PERSON", "RESPONSE"], ["PHASE", "SHAPE"], ["POST", "SPOT"], ["POST", "STOP"], ["PRESENT", "REPRESENT"], ["PROCEDURE", "PRODUCE"], ["PROVIDE", "PROVIDED"], ["QUIET", "QUITE"], ["RATE", "TEAR"], ["RATE", "TREAT"], ["RATHER", "THEATRE"], ["RATHER", "THREAT"], ["READ", "READER"], ["REFUSE", "SUFFER"], ["RESEARCH", "SEARCH"], ["RESOURCE", "SOURCE"], ["REST", "STREET"], ["RISE", "SERIES"], ["SCIENCE", "SINCE"], ["SEAT", "STATE"], ["SERVE", "SEVERE"], ["SET", "TEST"], ["SHEET", "THESE"], ["SHOOT", "SHOT"], ["SHOUT", "SOUTH"], ["SHUT", "THUS"], ["SIGN", "SING"], ["SON", "SOON"], ["SPOT", "STOP"], ["STAR", "START"], ["SURE", "USER"], ["TEAR", "TREAT"], ["THEATRE", "THREAT"], ["THEM", "THEME"], ["THOUGH", "THOUGHT"], ["THROUGH", "THROUGHOUT"], ["THROW", "WORTH"], ["TO", "TOO"], ["WRITE", "WRITER"]]
interesting_pairs.sort! {|a,b| b.collect{|x| x.length}.max <=> a.collect{|x| x.length}.max}

# puts interesting_pairs.first



# puts interesting_pairs.length


