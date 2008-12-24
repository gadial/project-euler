# Euler published the remarkable quadratic formula:
# 
# n² + n + 41
# 
# It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.
# 
# Using computers, the incredible formula  n² 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, 79 and 1601, is 126479.
# 
# Considering quadratics of the form:
# 
#     n² + an + b, where |a| 1000 and |b| 1000
# 
#     where |n| is the modulus/absolute value of n
#     e.g. |11| = 11 and |4| = 4
# 
# Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.


#maximum value possible from the formula: 87400.
#also, for n=0 we must have prime, so b must be prime AND POSITIVE
#also, for n=1 we must have prime, so 1+a+b must be larger than 1, i.e. a+b larger than zero, i.e. a>-b

require 'miller-rabin'

def sequence_length(a,b)
	80.times {|n| return n if not (n**2+a*n+b).prime?}		
end

primes_less_than_1000=(2..1000).reject{|x| not x.prime?(10)}

results = []
primes_less_than_1000.each do |b|
	(-b).upto(999) do |a|
		results << [a,b,sequence_length(a,b)]
	end
end

final=results.max{|a,b| a[2] <=> b[2]}
puts final[0]*final[1]
