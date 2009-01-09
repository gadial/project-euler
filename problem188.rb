# The hyperexponentiation or tetration of a number a by a positive integer b, denoted by a↑↑b or ^(b)a, is recursively defined by:
# 
# a↑↑1 = a,
# a↑↑(k+1) = a^((a↑↑k)).
# 
# Thus we have e.g. 3↑↑2 = 3^(3) = 27, hence 3↑↑3 = 3^(27) = 7625597484987 and 3↑↑4 is roughly 10^(3.6383346400240996*10^12).
# 
# Find the last 8 digits of 1777↑↑1855.

#remember Euler's theorem - a^(phi(n))=1 (mod n)

#in our case, last 8 digits means n=10**8
require 'common'
class Integer
    def phi
	prime_divisors.uniq.inject(self){|prod, p| prod*(p-1) / p}
    end
end
n=10**8
phi = n.phi
base = 1777
power = 1855
current = 1

power.times{current = fast_modular_exponent(base,current % phi,n)}
puts current