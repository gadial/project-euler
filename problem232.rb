# Two players share an unbiased coin and take it in turns to play "The Race". On Player 1's turn, he tosses the coin once: if it comes up Heads, he scores one point; if it comes up Tails, he scores nothing. On Player 2's turn, she chooses a positive integer T and tosses the coin T times: if it comes up all Heads, she scores 2^(T-1) points; otherwise, she scores nothing. Player 1 goes first. The winner is the first to 100 or more points.
# 
# On each turn Player 2 selects the number, T, of coins that maximises the probability of her winning.
# 
# What is the probability that Player 2 wins?
# 
# Give your answer rounded to eight decimal places in the form 0.abcdefgh .
$Game = {}

def compute_game(n,k)
    #player 1 needs n points to win, player 2 needs k points
    #player 2 goes first, since we want her strategy to be as up-to-date as possible
    return $Game[[n,k]] if $Game[[n,k]]
    return 1 if k <= 0
    return 0 if k > 0 and n <= 0
    strategies = [2]
    while strategies.last < 2*k
	strategies << strategies.last * 2
    end
    
    probabilities = strategies.collect do |t|
	p1_succ_prob = 1.to_f / 2
	p2_succ_prob = 1.to_f / t
	p1_fail_prob = 1 - p1_succ_prob
	p2_fail_prob = 1 - p2_succ_prob
	p2_win_value = t / 2

	(p1_succ_prob*p2_succ_prob*compute_game(n-1,k - p2_win_value) + 
	p1_succ_prob*p2_fail_prob*compute_game(n-1,k)+
	p1_fail_prob*p2_succ_prob*compute_game(n,k - p2_win_value)) / (1-p1_fail_prob*p2_fail_prob)
    end
    $Game[[n,k]] = probabilities.max
    return $Game[[n,k]]
end

# puts compute_game(100,100)
n = 100
prob = 0.5 * compute_game(n,n) + 0.5 * compute_game(n-1,n)
printf("%.8f\n", prob)