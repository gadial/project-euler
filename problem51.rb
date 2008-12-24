# By replacing the 1st digit of *57, it turns out that six of the possible values: 157, 257, 457, 557, 757, and 857, are all prime.
# i
# By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.
# 
# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.
require 'miller-rabin'
primes = File.open("primes.txt","r"){|file| file.read}.split(",").collect{|x| x.to_i}

def pattern_primes(pattern)
	(0..9).collect{|i| (pattern.gsub('*', i.to_s))}.reject{|x| not x.to_i.prime? or x[0..0]=="0"}
end

def all_patterns(upto)
	(1..upto).collect{|num| num.to_s(11).gsub("a","*")}.reject{|s| s.index("*") == nil}
end

max = 2*10**6
min = 10**6
results = []
(min..max).each do |num|
	next if ([0,2,4,6,8].include?(num % 11))
	puts "#{100*(num - min) / max}%"
	s = num.to_s(11).gsub("a","*")
	next if s.index("*") == nil
	results << s if pattern_primes(s).length == 8
end


puts results.collect{|s| pattern_primes(s)}.flatten.min
