# The radical of n, rad(n), is the product of distinct prime factors of n. For example, 504 = 23  32  7, so rad(504) = 2  3  7 = 42.
# 
# If we calculate rad(n) for 1 n 10, then sort them on rad(n), and sorting on n if the radical values are equal, we get:
# Unsorted
# Let E(k) be the kth element in the sorted n column; for example, E(4) = 8 and E(6) = 9.
# 
# If rad(n) is sorted for 1 n 100000, find E(10000).

require 'common'
max = 100000

radical = (0..max).collect{|n| [1,n]}
$Primes.reject{|p| p>max}.each {|p| (1..max / p).each{|i| radical[i*p][0]*=p}}
puts radical.sort[10000][1]




