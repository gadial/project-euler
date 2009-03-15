# The radical of n, rad(n), is the product of distinct prime factors of n. For example, 504 = 2^(3) × 3^(2) × 7, so rad(504) = 2 × 3 × 7 = 42.
# 
# We shall define the triplet of positive integers (a, b, c) to be an abc-hit if:
# 
#    1. GCD(a, b) = GCD(a, c) = GCD(b, c) = 1
#    2. a < b
#    3. a + b = c
#    4. rad(abc) < c
# 
# For example, (5, 27, 32) is an abc-hit, because:
# 
#    1. GCD(5, 27) = GCD(5, 32) = GCD(27, 32) = 1
#    2. 5 < 27
#    3. 5 + 27 = 32
#    4. rad(4320) = 30 < 32
# 
# It turns out that abc-hits are quite rare and there are only thirty-one abc-hits for c < 1000, with ∑c = 12523.
# 
# Find ∑c for c < 110000.
# 
require 'common'

class Integer
    def radical(factors = nil)
	factors = prime_divisors.uniq unless factors
	factors.prod
    end
end	

max = 110000
factor_array = []
(max+1).times {factor_array << []}
(2..max).each do |n|
    next unless factor_array[n].empty? #n is prime
    temp = n
    while temp <= max
	factor_array[temp] << n
	temp += n
    end
end

radical_array = [1,1]
(2..max).each {|n| radical_array << n.radical(factor_array[n])}

sorted_radical_array = radical_array.collect_with_index{|x,i| [x,i]}.sort #an important optimization - without it, the code runs for hours

results = []
(2..max).each do |c|
    puts c
    next if c == radical_array[c]
    sorted_radical_array.each do |pair|
	break if pair.first * radical_array[c] >= c
	a = pair.last
	b = c-a
	next if a >= b
	next unless radical_array[a]*radical_array[b]*radical_array[c] < c
	results << c if ((factor_array[a] & factor_array[b]).empty? and (factor_array[a] & factor_array[c]).empty? and (factor_array[b] & factor_array[c]).empty?)
    end
end

puts results.sum
