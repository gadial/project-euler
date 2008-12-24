# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# 
# What is the 10001st prime number?
def sieve(max)
	temp = (2..max).to_a
	primes = []
	while not temp.empty?
		p = temp.shift
		primes << p
		temp.reject!{|x| x % p ==0}
	end
	return primes
end
result = sieve(2*10**5)

puts result[10000]