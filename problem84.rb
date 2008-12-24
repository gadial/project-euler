# In the game, Monopoly, the standard board is set up in the following way:
# GO 	A1 	CC1 	A2 	T1 	R1 	B1 	CH1 	B2 	B3 	JAIL
# H2 	  	C1
# T2 	  	U1
# H1 	  	C2
# CH3 	  	C3
# R4 	  	R2
# G3 	  	D1
# CC3 	  	CC2
# G2 	  	D2
# G1 	  	D3
# G2J 	F3 	U2 	F2 	F1 	R3 	E3 	E2 	CH2 	E1 	FP
# 
# A player starts on the GO square and adds the scores on two 6-sided dice to determine the number of squares they advance in a clockwise direction. Without any further rules we would expect to visit each square with equal probability: 2.5%. However, landing on G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.
# 
# In addition to G2J, and one card from each of CC and CH, that orders the player to go to directly jail, if a player rolls three consecutive doubles, they do not advance the result of their 3rd roll. Instead they proceed directly to jail.
# 
# At the beginning of the game, the CC and CH cards are shuffled. When a player lands on CC or CH they take a card from the top of the respective pile and, after following the instructions, it is returned to the bottom of the pile. There are sixteen cards in each pile, but for the purpose of this problem we are only concerned with cards that order a movement; any instruction not concerned with movement will be ignored and the player will remain on the CC/CH square.
# 
#     * Community Chest (2/16 cards):
#          1. Advance to GO
#          2. Go to JAIL
#     * Chance (10/16 cards):
#          1. Advance to GO
#          2. Go to JAIL
#          3. Go to C1
#          4. Go to E3
#          5. Go to H2
#          6. Go to R1
#          7. Go to next R (railway company)
#          8. Go to next R
#          9. Go to next U (utility company)
#         10. Go back 3 squares.
# 
# The heart of this problem concerns the likelihood of visiting a particular square. That is, the probability of finishing at that square after a roll. For this reason it should be clear that, with the exception of G2J for which the probability of finishing on it is zero, the CH squares will have the lowest probabilities, as 5/8 request a movement to another square, and it is the final square that the player finishes at on each roll that we are interested in. We shall make no distinction between "Just Visiting" and being sent to JAIL, and we shall also ignore the rule about requiring a double to "get out of jail", assuming that they pay to get out on their next turn.
# 
# By starting at GO and numbering the squares sequentially from 00 to 39 we can concatenate these two-digit numbers to produce strings that correspond with sets of squares.
# 
# Statistically it can be shown that the three most popular squares, in order, are JAIL (6.24%) = Square 10, E3 (3.18%) = Square 24, and GO (3.09%) = Square 00. So these three most popular squares can be listed with the six-digit modal string: 102400.
# 
# If, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit modal string.
require 'common'
class Array
	def normalize
		collect {|x| x.to_f / sum}
	end
	def delete_at_random
		delete_at(rand(length))
	end
	def shuffle
		temp = self.dup
		result = []
		while not temp.empty?
			result << temp.delete_at_random
		end
		return result
	end
end

$Board = [:GO, :A1, :CC1, :A2, :T1, :R1, :B1, :CH1, :B2, :B3, :JAIL, :C1, :U1, :C2, :C3, :R2, :D1, :CC2, :D2, :D3, :FP, :E1, :CH2, :E2, :E3, :R3, :F1, :F2, :U2, :F3, :G2J, :G1, :G2, :CC3, :G3, :R4, :CH3, :H1, :T2, :H2]
$CC_SQUARES = [:CC1, :CC2, :CC3]
$CH_SQUARES = [:CH1, :CH2, :CH3]
$CC = [:GO, :JAIL]+[:none]*14
$CH = [:GO, :JAIL, :C1, :E3, :H2, :R1, :R, :R, :U, :B3]+[:none]*6
$Dice = 4
$Steps = 800000
class Monopoly
	attr_accessor :cc_cards, :ch_cards, :place, :visited, :double_streak_length
	def initialize
		self.cc_cards = $CC.shuffle
		self.ch_cards = $CH.shuffle
		self.place = 0
		self.visited = [0]*$Board.length
		self.double_streak_length = 0
	end
	def say(text)
# 		puts text
	end
	def location
		[self.place, $Board[self.place]]
	end
	def play_step
		roll1, roll2 = rand($Dice)+1,rand($Dice)+1
		say "location: #{location.inspect}. rolled #{roll1}, #{roll2}"
		if roll1 == roll2
			self.double_streak_length += 1
			if self.double_streak_length == 3
				goto(:JAIL)
# 				puts "went to jail! location = #{self.place}"
				self.visited[self.place] += 1
				return
			end
		else
			self.double_streak_length = 0
		end

		goto(roll1+roll2)
# 		puts "current square: #{$Board[self.place]}, is in? #{$CC_SQUARES.include?($Board[self.place]) or $CH_SQUARES.include?($Board[self.place])}"
		self.visited[self.place] += 1
	end
	def play_naive_step
		roll1, roll2 = rand($Dice),rand($Dice)
		goto(roll1+roll2)
		self.visited[self.place] += 1
	end
	def draw_community_chest
		card = self.cc_cards.shift
		say "community chest card: #{card}"
		goto(card) unless card == :none
		self.cc_cards.push(card)
	end
	def draw_chance
		card = self.ch_cards.shift
		say "chance card: #{card}"
		goto(card) if (card == :GO or card == :JAIL or card == :C1 or card == :E3 or card == :H2 or card == :R1)
		goto(next_rail) if card == :R
		goto(next_utility) if card == :U
		goto(-3) if card == :B3
		self.ch_cards.push(card)

	end
	def next_rail
		say "finding next rail"
		rail_locations = (0..$Board.length).find_all{|x| [:R1, :R2, :R3, :R4].include?($Board[x])}
		say "rail locations: #{rail_locations.inspect}"
		t = 0
		while (t<rail_locations.length and self.place > rail_locations[t])
			t += 1
		end
# 		say "t=#{t}, result=#{$Board[rail_locations[t]]}"
		$Board[rail_locations[t % rail_locations.length]]
	end
	def next_utility
		utility_locations = (0..$Board.length).find_all{|x| [:U1, :U2].include?($Board[x])}
		t = 0
		while (t<utility_locations.length and self.place > utility_locations[t])
			t += 1
		end
		$Board[utility_locations[t % utility_locations.length]]
	end
	def play_game
		$Steps.times do
			play_step
		end
		show_results
	end
	def show_results
# 		puts self.visited.normalize.collect_with_index{|x,i| ["#{(100.to_f*x)}%", $Board[i].to_s]}.inspect
		results = self.visited.normalize.collect_with_index{|x,i| [x,i]}.sort{|a,b| b[0] <=> a[0]}
		results.collect!{|x| ["#{(100.to_f*x[0])}%",$Board[x[1]].to_s,x[1]]}
		puts results.inspect
	end
	def goto(square)
		case square
			when Symbol: self.place = $Board.index(square)
			when Integer: self.place = ((self.place+square) % $Board.length)
		end
		say "moved to #{location.inspect}"
		draw_community_chest if $CC_SQUARES.include?($Board[self.place])
		draw_chance if $CH_SQUARES.include?($Board[self.place])
		goto(:JAIL) if $Board[self.place] == :G2J
	end
end

Monopoly.new.play_game
