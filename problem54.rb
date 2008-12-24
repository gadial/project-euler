# In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:
# 
#     * High Card: Highest value card.
#     * One Pair: Two cards of the same value.
#     * Two Pairs: Two different pairs.
#     * Three of a Kind: Three cards of the same value.
#     * Straight: All cards are consecutive values.
#     * Flush: All cards of the same suit.
#     * Full House: Three of a kind and a pair.
#     * Four of a Kind: Four cards of the same value.
#     * Straight Flush: All cards are consecutive values of same suit.
#     * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# 
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
# 
# If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.
# 
# Consider the following five hands dealt to two players:
# Hand	 	Player 1	 	Player 2	 	Winner
# 1	 	5H 5C 6S 7S KD
# Pair of Fives
# 	 	2C 3S 8S 8D TD
# Pair of Eights
# 	 	Player 2
# 2	 	5D 8C 9S JS AC
# Highest card Ace
# 	 	2C 5C 7D 8S QH
# Highest card Queen
# 	 	Player 1
# 3	 	2D 9C AS AH AC
# Three Aces
# 	 	3D 6D 7D TD QD
# Flush with Diamonds
# 	 	Player 2
# 4	 	4D 6S 9H QH QC
# Pair of Queens
# Highest card Nine
# 	 	3D 6D 7H QD QS
# Pair of Queens
# Highest card Seven
# 	 	Player 1
# 5	 	2H 2D 4C 4D 4S
# Full House
# With Three Fours
# 	 	3C 3D 3S 9S 9D
# Full House
# with Three Threes
# 	 	Player 1
# 
# The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.
# 
# How many hands does Player 1 win?
class Array
	def count(x)
		self.find_all{|y| y==x}.size
	end
	def find_occurences(num)
		result = []
		temp = {}
		self.each{|x| temp[x]||=0; temp[x]+=1; result << x if temp[x]==num}
		return result 
	end
end

$Suits = {
	:clubs 		=> 0,
	:diamonds 	=> 1,
	:hearts		=> 2,
	:spades		=> 3
	}

$Ranks = {
	:high_card 		=> 0,
	:one_pair		=> 1,
	:two_pairs		=> 2,
	:three_of_a_kind	=> 3,
	:straight		=> 4,
	:flush			=> 5,
	:full_house		=> 6,
	:four_of_a_kind		=> 7,
	:straight_flush		=> 8,
	:royal_flush		=> 9
	}

class Card
	include Comparable
	attr_accessor :value, :suit
	def Card.from_s(s)
		Card.new(name_to_value(s[0..0]),name_to_suit(s[1..1]))
	end
	def initialize(value, suit)
		self.value = value
		self.suit = suit
	end
	def <=>(other)
		temp = (self.value <=> other.value)
		((temp != 0)?(temp):($Suits[self.suit] <=> $Suits[other.suit]))
	end
	def value_to_name
		case self.value
			when (2..9): return self.value.to_s
			when 10: return "T"
			when 11: return "J"
			when 12: return "Q"
			when 13: return "K"
			when 14: return "A"
		end	
	end
	def Card.name_to_value(name)
		return name.to_i if (2..9).include?(name.to_i)
		case name
			when "T": return 10
			when "J": return 11
			when "Q": return 12
			when "K": return 13
			when "A": return 14
		end
		raise "#{name} is not a legal card"
	end
	def suit_to_name
		case self.suit
			when :clubs: 		return "C"
			when :diamonds: 	return "D"
			when :hearts:		return "H"
			when :spades:		return "S"
		end
	end
	def Card.name_to_suit(name)
		case name
			when "C": return :clubs
			when "D": return :diamonds
			when "H": return :hearts
			when "S": return :spades
		end
		raise "#{name} is not a legal suit"
	end
	def to_s
		value_to_name+suit_to_name
	end
	def inspect
		to_s
	end
end

class Hand
	include Comparable
	attr_accessor :cards, :score
	def initialize(cards)
		self.cards = cards.sort
		self.score = calculate_score
	end
	def values
		self.cards.collect{|card| card.value}.sort
	end
	def values_big_to_small
		self.cards.collect{|card| card.value}.sort{|a,b| b <=> a}
	end
	def repeated_values
		values.uniq.collect{|val| values.count(val)}.sort
	end
	def one_pair?
		repeated_values == [1,1,1,2]
	end
	def one_pair_score
		[$Ranks[:one_pair], values.find_occurences(2).first,values_big_to_small]
	end
	def two_pairs?
		repeated_values == [1,2,2]
	end
	def two_pairs_score
		[$Ranks[:two_pairs], values.find_occurences(2).first,values.find_occurences(2).last,values_big_to_small]
	end
	def three_of_a_kind?
		repeated_values == [1,1,3]
	end
	def three_of_a_kind_score
		[$Ranks[:three_of_a_kind], values.find_occurences(3).first,values_big_to_small]
	end
	def straight?
		(values.first..values.first+4).each {|val| return false unless values.include?(val)}
	end
	def straight_score
		[$Ranks[:straight], values_big_to_small]
	end
	def flush?
		#all five cards of the same suit?
		self.cards.collect{|card| card.suit}.uniq.size == 1
	end
	def flush_score
		[$Ranks[:flush], values_big_to_small]
	end
	def full_house?
		repeated_values == [2,3]
	end
	def full_house_score
		t1=values.find_occurences(3).first
		t2=values.find_occurences(2).first
		[$Ranks[:full_house], t1,t2,values_big_to_small]
	end
	def four_of_a_kind?
		repeated_values == [1,4]
	end
	def four_of_a_kind_score
		t = values.find_occurences(4).first
		[$Ranks[:four_of_a_kind],t,values_big_to_small]
	end
	def straight_flush?
		straight? and flush?
	end
	def straight_flush_score
		[$Ranks[:straight_flush], values_big_to_small]
	end
	def royal_flush?
		straight_flush? and values.first == 10
	end
	def royal_flush_score
		[$Ranks[:royal_flush]]
	end
	def flush_suit
		self.cards.first.suit
	end
	def repeated_values_vals
		values.uniq.collect{|val| [val,values.count(val)]}.sort{|a,b| a[1] <=> b[1]}
	end
	def calculate_score
		return royal_flush_score if royal_flush?
		return straight_flush_score if straight_flush?
		return four_of_a_kind_score if four_of_a_kind?
		return full_house_score if full_house?
		return flush_score if flush?
		return straight_score if straight?
		return three_of_a_kind_score if three_of_a_kind?
		return two_pairs_score if two_pairs?
		return one_pair_score if one_pair?
		return [$Ranks[:high_card], values_big_to_small]
	end
	def <=> (other_hand)
		score <=> other_hand.score
	end
	def inspect
		"Cards: #{self.cards.inspect}. Score: #{score.first.to_s}"
	end
end

def two_hands_from_line(line)
	cards=line.split(" ").collect{|s| Card.from_s(s)}
	[Hand.new(cards[0..4]), Hand.new(cards[5..9])]
end

def winner_for_line(line)
	hands = two_hands_from_line(line)
	return 1 if hands.first > hands.last
	return 2
end

puts File.open("poker.txt","r"){|file| file.read.split("\n")}.collect{|line| winner_for_line(line)}.count(1)