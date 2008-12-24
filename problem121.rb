# A bag contains one red disc and one blue disc. In a game of chance a player takes a disc at random and its colour is noted. After each turn the disc is returned to the bag, an extra red disc is added, and another disc is taken at random.
# 
# The player pays £1 to play and wins if they have taken more blue discs than red discs at the end of the game.
# 
# If the game is played for four turns, the probability of a player winning is exactly 11/120, and so the maximum prize fund the banker should allocate for winning in this game would be £10 before they would expect to incur a loss. Note that any payout will be a whole number of pounds and also includes the original £1 paid to play the game, so in the example given the player actually wins £9.
# 
# Find the maximum prize fund that should be allocated to a single game in which fifteen turns are played.

#again, dynamic programming seems relevant
require 'frac'

$Val = {}
$TotalRounds = 15
def chance_to_win(rounds_left, score)
    return (score > 0)?(1):(0) if rounds_left == 0
    return $Val[[rounds_left,score]] unless $Val[[rounds_left,score]] == nil
    total_disc_number = $TotalRounds - rounds_left + 2
    chance_for_blue_disc = Frac.new(1) / total_disc_number
    chance = chance_for_blue_disc*chance_to_win(rounds_left - 1, score + 1) + (1-chance_for_blue_disc)*chance_to_win(rounds_left - 1, score - 1)
    $Val[[rounds_left,score]] = chance
    return chance
end

puts chance_to_win($TotalRounds,0).reciprocal.to_i
