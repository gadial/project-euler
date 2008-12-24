# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.
# 
# Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

require 'common'
require 'miller-rabin'

def good_pair?(p,q)
	(p.to_s+q.to_s).to_i.prime? and (q.to_s+p.to_s).to_i.prime?
end

max = 10000

primes = (3..max).find_all{|x| x.prime?} #2 is obviously not helpful

def find_good_set(numbers,i)
	return [] if i==0
	while not numbers.empty?
		x = numbers.shift
		test = find_good_set(numbers.find_all{|y| good_pair?(x,y)},i-1)
		return [x]+test unless test == nil
	end
	return nil
end

puts find_good_set(primes,5).sum