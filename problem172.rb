# How many 18-digit numbers n (without leading zeros) are there such that no digit occurs more than three times in n?
require 'common'
$Max = 3
def f(n,remaining_digits)
  return 1 if n == 0
  return 0 if n > 0 and remaining_digits == 0
  (0..[n,$Max].min).collect{|i| f(n-i,remaining_digits - 1)*choose(n,i)}.sum
end

n = 18
puts (0..3).collect{|i| f(n-i,9)*choose(n-1,i)}.sum
