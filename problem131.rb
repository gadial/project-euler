# There are some prime values, p, for which there exists a positive integer, n, such that the expression n^(3) + n^(2)p is a perfect cube.
# 
# For example, when p = 19, 8^(3) + 8^(2)×19 = 12^(3).
# 
# What is perhaps most surprising is that for each prime with this property the value of n is unique, and there are only four such primes below one-hundred.
# 
# How many primes below one million have this remarkable property?

#assume x^3+x^2p=y^3, so x^2(x+p)=y^3
#it is easy to see that gcd(x^2,x+p)=1 or p.
#if it is 1, then x=a^3 and x+p=b^3 for some a,b
#so p=b^3-a^3=(b-a)(a^2+ab+b^2)
#since p is prime, b-a = 1, so b=a+1
#and so p=a^2+ab+b^2=a^2+a(a+1)+(a+1)^2=a^2+a^2+a+a^2+2a+1 = 3a(a+1)+1
require 'common'
max = 10**6
results = sieve_primes(max).find_all do |p|
    puts p
    a = solve_equation(3,3,1-p).to_i
    p == 3*a*(a+1)+1
end

puts results.length