#In the following equation x, y, and n are positive integers.
#
#For n = 4 there are exactly three distinct solutions:
#
#What is the least value of n for which the number of distinct solutions exceeds one-thousand?
#
#NOTE: This problem is an easier version of problem 110; it is strongly advised that you solve this one first.

#We are counting the number of x's such that (n*x) % (x-n) == 0
#Changing variables, we are interested in z such that n(z+n) % z == 0
#In other words, z such that (n^2 / z) + n is an integer, i.e. z divides n^2
#Bottom line - if d(t) is the number of divisors of t, we want (d(n^2) + 1) / 2  
require 'common'
def array_to_num(array)
    primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
    array.inject(1){|prod, k| prod * (primes.shift ** k)} 
end
def total_value(prime_divisors)
=begin
prime divisors[i] is the power of the (i+1)th prime in the number we're checking
e.g. [1,2,0,1] stands for 2*9*7=126
=end
 (prime_divisors.inject(1){|prod, k| prod * (2*k+1)} + 1) / 2 
end

def find_candidate(current, max)
  return current if total_value(current) > max
  candidates = []
  current << 1
  while total_value(current) <= max
    candidates << find_candidate(current.dup, max)
    current[-1] += 1
  end
  candidates << current
  return candidates.min{|a,b| array_to_num(a) <=> array_to_num(b)}
end

max = 1000
puts array_to_num(find_candidate([],max))
#puts array_to_num([1,2,0,1])
