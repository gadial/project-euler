#"The Chase" is a game played with two dice and an even number of players.
#
#The players sit around a table; the game begins with two opposite players having one die each. On each turn, the two players with a die roll it.
#If a player rolls a 1, he passes the die to his neighbour on the left; if he rolls a 6, he passes the die to his neighbour on the right; otherwise, he keeps the die for the next turn.
#The game ends when one player has both dice after they have been rolled and passed, that player has then lost.
#
#In a game with 100 players, what is the expected number of turns the game lasts?
#
#Give your answer rounded to ten significant digits.

#The game can be modelled the following way:
#We have a number n of players and a number k - "the gap".
#Initially, k = n / 2
#Each turn, k can change by up to 2, according to the rules
#The game ends when k = 0 (mod n)

#The probability for a change of 2 is 1 / 36 for plus, 1 / 36 for minus
#For a change of 1 it's 8 / 36 for plus, 8 / 36 for minus
#The rest is 18 / 36 for no change at all

#This is a standard discrete markov chain, and can be solved by the standard technique of finding hitting times
#This sums up to solving a certain linear equation
require 'common'
require 'linear'
require 'frac'
n = 100
matrix = []
matrix[0]=[1]+[0]*(n-1)
(1...n).each do |k|
    temp_row = [0]*n
    temp_row[k] = 1
    temp_row[(k+1)%n] = Frac.new(-4,9)
    temp_row[(k-1)%n] = Frac.new(-4,9)
    temp_row[(k+2)%n] = Frac.new(-1,18)
    temp_row[(k-2)%n] = Frac.new(-1,18)
    matrix[k] = temp_row
end
b = [1]+[2]*(n-1)

result = solve_linear_equation_system(matrix,b)
puts result[n / 2].to_f - 1
