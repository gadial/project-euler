#For an integer n ≥ 4, we define the lower prime square root of n, denoted by lps(n), as the largest prime ≤ √n and the upper prime square root of n, ups(n), as the smallest prime ≥ √n.
#
#So, for example, lps(4) = 2 = ups(4), lps(1000) = 31, ups(1000) = 37.
#Let us call an integer n ≥ 4 semidivisible, if one of lps(n) and ups(n) divides n, but not both.
#
#The sum of the semidivisible numbers not exceeding 15 is 30, the numbers are 8, 10 and 12.
#15 is not semidivisible because it is a multiple of both lps(15) = 3 and ups(15) = 5.
#As a further example, the sum of the 92 semidivisible numbers up to 1000 is 34825.
#
#What is the sum of all semidivisible numbers not exceeding 999966663333 ?

#we give a naive solution - we can do better if instead of summing we use the formula for arithmetic series
require 'common'
require 'miller-rabin'
def next_prime(last_prime)
  current = last_prime + 2
  while not current.prime?
    current += 2
  end
  return current
end
max = 999966663333
sum = 0

max_prime = Math.sqrt(max).to_i
primes = sieve_primes(max_prime)
primes << next_prime(primes.last)
(primes.length-1).times do |i|
  p = primes[i]
  q = primes[i+1]

  max_for_p = ((q**2-p**2) / p)
  (1..max_for_p).each do |j|
    sum += p*(p+j) unless ((p+j) % q == 0 or p*(p+j) > max)
    count += 1 unless ((p+j) % q == 0 or p*(p+j) > max)
  end

  max_for_q = ((q**2-p**2) / q)
  (1..max_for_q).each do |j|
    sum += q*(q-j) unless ((q-j) % p == 0 or q*(q-j) > max)
    count += 1 unless ((q-j) % p == 0 or q*(q-j) > max)
  end
end
puts sum
