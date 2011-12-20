#Consider the divisors of 30: 1,2,3,5,6,10,15,30.
#It can be seen that for every divisor d of 30, d+30/d is prime.

#Find the sum of all positive integers n not exceeding 100 000 000
#such that for every divisor d of n, d+n/d is prime.

#Easy to see that n>1 has to be:
#1) Even, otherwise d and n/d will both be odd and so d+n/d even.
#2) Square-free, otherwise p will divide both p and n/p, and so their sum.

#max = 10^8

import itertools

max_val = 10^8
max_prime_range = max_val / 2
primes = prime_range(max_prime_range)
primes.remove(2)
def test(n):
	n = Integer(n)
	for d in n.divisors():
		if not Integer(d+n/d).is_prime():
			return False
	return True

def forbidden_mod_p(p, divisors):
	return [(-d^2)%p for d in divisors] #if n = -d^2 (mod p) then  n/d + d is divisble by p

def prime_set_ok(prime_set):
	n = prod(prime_set)
	if not Integer(n+1).is_prime():
		return False
	for k in range(1,len(prime_set)):
		for s in itertools.combinations(prime_set, k):
			d = prod(s)
			if not Integer(d+n/d).is_prime():
				return False
	return True
	
def find_good_numbers(current_primes, index):
	current_prod = prod(current_primes)
	result = 0
	while index < len(primes) and (current_prod * primes[index])<=max_val:
		new_primes = current_primes + [primes[index]]
		if prime_set_ok(new_primes):
			result = result + prod(new_primes)
			#print new_primes
		result += find_good_numbers(new_primes, index + 1)
		index += 1
	return result
		

print 1 + 2 + find_good_numbers([2],0)
#print sum([n for n in range(1,max_val+1) if test(n)])
#print [Integer(n).prime_factors() for n in range(1,max_val+1) if test(n)]
#print len(prime_range(5*10^7))
#print [Integer(n).prime_divisors() for n in range(1,1000) if test(n)]
#r = 2000
#print [Integer(n) for n in range(1,r) if test(n)]
#print [Integer(n) % 2 for n in range(1,r) if test(n)]
#print [Integer(n) % 3 for n in range(1,r) if test(n)]
#print [Integer(n) % 5 for n in range(1,r) if test(n)]
#print [Integer(n) % 7 for n in range(1,r) if test(n)]
#print [Integer(n) % 11 for n in range(1,r) if test(n)]

#print "forbidden mod 5:"
#print forbidden_mod_p(5,[1,2])