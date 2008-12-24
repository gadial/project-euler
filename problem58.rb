# Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
# 
# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49
# 
# It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 62%.
# 
# If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
require 'miller-rabin'

n=1
primes = 3
total = 5

def new_num(a0,n)
	4*n*n+(a0-4)*n+1 #the formula for an element on the diagonal - comes from a simple arithmetic series
end

while (100*primes.to_f / total) >= 10
	n +=1
	[2,4,6,8].each{|x| primes +=1 if new_num(x,n).prime?}
	total += 4
end

puts 1+2*n