# It is possible to write ten as the sum of primes in exactly five different ways:
# 
# 7 + 3
# 5 + 5
# 5 + 3 + 2
# 3 + 3 + 2 + 2
# 2 + 2 + 2 + 2 + 2
# 
# What is the first value which can be written as the sum of primes in over five thousand different ways?
require 'common'
def count_ways_to_make_sum(sum,coins)
	return 1 if coins.length == 0 and sum == 0
	return 0 if coins.length == 0 and sum != 0 #oops
	t=coins.max
	(0..(sum / t)).inject(0){|ways,i| ways + count_ways_to_make_sum(sum - i*t, coins - [t])}
end

temp = 10

while true
	coins = $Primes.reject{|x| x > temp}
	ways = count_ways_to_make_sum(temp,coins)
	puts "#{temp}: #{ways}"
	break if  ways > 5000
	temp += 1
end

puts temp