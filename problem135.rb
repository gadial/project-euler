# Given the positive integers, x, y, and z, are consecutive terms of an arithmetic progression, the least value of the positive integer, n, for which the equation, x^(2) − y^(2) − z^(2) = n, has exactly two solutions is n = 27:
# 
# 34^(2) − 27^(2) − 20^(2) = 12^(2) − 9^(2) − 6^(2) = 27
# 
# It turns out that n = 1155 is the least value which has exactly ten solutions.
# 
# How many values of n less than one million have exactly ten distinct solutions?

# 4x^2-y^2 = n
# d = y
# a = x+y / x-y

#and so given n, we want to see if there are FIVE different ways to write it as n=(2y-x)(2y+x)
#we have y = (a+b) / 4 and x = (a-b) / 2
#so our defining condition is (a+b) % 4 == 0
#from n = 4x^2-y^2 we know that n = 0,3 modulo 4
#each ab=n pair gives rise to one x,y pair, giving rise to the progression y+x, 2y+x, 3y+x.
#since we want the solutions to be positive, we must have y+x >0, so (a+b) / 4 > (b-a) / 2
#this leads to b < 3a

#so we want to count
#1) n = 3 modulo 4 with exactly 10 such divisor pairs (a,b) with b < 3a
#2) n = 0 modulo 4, with exactly 10 pairs of such divisors (a,b) such that a and b are also even
require 'common'

def is_ok?(goal,factors, n=factors.max)
    return factors.reject{|a| n >= 3*a**2}.length == goal if n % 4 == 3
    return factors.reject{|a| n >= 3*a**2 or ((a + (n / a)) % 4 != 0)}.length == goal if n % 4 == 0
    return false
end

max = 10**6
solutions = 10

results = []
factors = []
(2..max).each{|n| factors[n] = [1]}
(2..max).each do |n|
    temp = n
    while temp <= max
      factors[temp] << n
      temp += n
    end
    n_factors = factors[n]
    puts n
    results << n if is_ok?(solutions,n_factors,n)
end

puts results.length