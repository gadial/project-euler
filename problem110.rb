#In the following equation x, y, and n are positive integers.
#
#It can be verified that when n = 1260 there are 113 distinct solutions and this is the least value of n for which the total number of distinct solutions exceeds one hundred.
#
#What is the least value of n for which the number of distinct solutions exceeds four million?
#
#NOTE: This problem is a much more difficult version of problem 108 and as it is well beyond the limitations of a brute force approach it requires a clever implementation.

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

$CurrentMin = 10**100
def find_candidate(current, current_value, max)
    primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
  return current if total_value(current) > max
  puts current.inspect
  candidates = []
  current << 1
  current_value *= primes[current.length-1]
  while total_value(current) <= max and current_value < $CurrentMin
    candidates << find_candidate(current.dup, current_value, max)
    current[-1] += 1
    current_value *= primes[current.length-1]
  end
  candidates << current
  $CurrentMin = current_value if current_value < $CurrentMin and total_value(current) > max
  return candidates.min{|a,b| array_to_num(a) <=> array_to_num(b)}
end

max = 4*10**6
puts array_to_num(find_candidate([],1,max))
#puts array_to_num([1,2,0,1])
