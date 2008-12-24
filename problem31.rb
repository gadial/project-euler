# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
# 
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# 
# It is possible to make £2 in the following way:
# 
#     1£1 + 150p + 220p + 15p + 12p + 31p
# 
# How many different ways can £2 be made using any number of coins?

def count_ways_to_make_sum(sum,coins)
	return 1 if coins.length == 0 and sum == 0
	return 0 if coins.length == 0 and sum != 0 #oops
	t=coins.max
	(0..(sum / t)).inject(0){|ways,i| ways + count_ways_to_make_sum(sum - i*t, coins - [t])}
end

coins = [200, 100, 50, 20, 10, 5, 2, 1]
sum = 200

puts count_ways_to_make_sum(sum,coins)