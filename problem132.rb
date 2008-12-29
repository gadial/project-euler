# A number consisting entirely of ones is called a repunit. We shall define R(k) to be a repunit of length k.
# 
# For example, R(10) = 1111111111 = 11×41×271×9091, and the sum of these prime factors is 9414.
# 
# Find the sum of the first forty prime factors of R(10^(9)).

require 'common'
def prime_find_cycle(p)
  already_seen = []
  i = 0
  value = 0
    while already_seen[value] == nil
      already_seen[value] = i
      value = ((value * 10)+1) % p
      i += 1
    end
    cycle_start = already_seen[value]
    cycle_end = i
    cycle_length = cycle_end - cycle_start
#    puts already_seen.inspect
#    puts "Cycle start = #{cycle_start}, cycle end = #{cycle_end}, cycle length = #{cycle_length}"
    return [cycle_start, cycle_length, value]
end
def divides_rk?(p, k)
  #computes R(k) modulo p
  cycle_start, cycle_length, value = prime_find_cycle(p)
  r = ((k-cycle_start) % cycle_length)
  r.times {value = ((value * 10) + 1) % p}
  return value == 0
end

k = 10**9
max = 40
primes = []
$Primes.each{|p| puts "#{primes.length}: #{p}"; primes << p if divides_rk?(p,k); break if primes.length >= max}
puts primes.sum