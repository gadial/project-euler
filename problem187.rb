# A composite is a number containing at least two prime factors. For example, 15 = 3 × 5; 9 = 3 × 3; 12 = 2 × 2 × 3.
# There are ten composites below thirty containing precisely two, not necessarily distinct, prime factors: 4, 6, 9, 10, 14, 15, 21, 22, 25, 26.
# How many composite integers, n < 10^(8), have precisely two, not necessarily distinct, prime factors?
require 'common'

def number_of_good_pairs(elements, max)
	puts elements.length
	return 0 if elements.empty?
	p = elements.first
	i = -1
	while (elements[i] != nil and p*elements[i] >= max)
		i -= 1
	end
	new_elements = elements[1..i]
	return number_of_good_pairs(new_elements,max) + (new_elements.length) + ((p**2 < max)?(1):(0))
end

$Primes = File.open("primes50.txt","r"){|file| file.read.split("\n").collect{|p| p.to_i}}
max = 10**8
puts number_of_good_pairs($Primes, max)