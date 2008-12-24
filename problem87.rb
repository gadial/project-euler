# The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28. In fact, there are exactly four numbers below fifty that can be expressed in such a way:
# 
# 28 = 22 + 23 + 24
# 33 = 32 + 23 + 24
# 49 = 52 + 23 + 24
# 47 = 22 + 33 + 24
# 
# How many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?

require 'common'

limit = 50*10**6


numbers = []

x,y,z=0,0,0

puts "go"
while $Primes[x]**2 < limit
	while $Primes[y]**3 < limit
		while $Primes[z]**4 < limit
			new_num = $Primes[x]**2+$Primes[y]**3+$Primes[z]**4
			numbers << new_num if new_num < limit
			z+=1
		end
		y+=1
		z=0
	end
	x+=1
	puts x
	y,z = 0,0
end

puts numbers.uniq.length