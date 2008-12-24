# Consider numbers t(n) of the form t(n) = 2n2-1 with n  1.
# The first such numbers are 7, 17, 31, 49, 71, 97, 127 and 161.
# It turns out that only 49 = 7*7 and 161 = 7*23 are not prime.
# For n 10000 there are 2202 numbers t(n) that are prime.
# 
# How many numbers t(n) are prime for n 50,000,000 ?
require 'common'
require 'miller-rabin'

max = 50*10**6
def f(x)
  2*x**2-1
end

# puts (2..100).collect{|x| f(x)}.reject{|x| x.prime?}.collect{|x| x.proper_divisors}.inspect
puts max.sqrt
# puts (2..100).collect{|x| f(x)}.find_all{|x| x.prime?}.inspect
primes = (3..300).find_all{|x| x.prime?}
good_primes = [7, 17, 23, 31, 41, 47, 71, 73, 79, 89, 97, 103, 113, 127, 137, 151, 167, 191, 193, 199, 223, 233, 239, 241, 257, 263, 271, 281]
# puts primes.find_all{|p| ((p+1) / 2).qr_modulo?(p)}.inspect
# puts max
# puts [7, 17, 23, 31, 41, 47].prod
# puts [5, 15, 21, 29, 39, 45].prod
# puts good_primes.inject(max){|cur, p| (cur*(p-2) / p)}