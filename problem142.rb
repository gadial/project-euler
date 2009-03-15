# Find the smallest x + y + z with integers x > y > z > 0 such that x + y, x − y, x + z, x − z, y + z, y − z are all perfect squares.

#This is NOT a good solution. It takes too long (but finds the right answer).
require 'common'
def list_all_pairs(max_sum)
	results = []
	(0...max_sum).each {|i| (0...i).each {|j| results << [i,j]}}
	results
end

class Array
    def all_pairs
	return [] if empty?
	list_all_pairs(length).collect{|pair| [self[pair.first],self[pair.last]]}
    end
end

n = 2
while true
    results = []
    a = 1
    while a**2 <= n / 2
	if (n-a**2).square?
	    b = (n-a**2).integer_sqrt 
	    results << [(b**2+a**2) / 2, (b**2 - a**2) / 2] if a%2 == b%2
	end
	a += 1
    end
    
#      puts "#{n}: #{results.inspect}" unless results.empty?
    results.all_pairs.each do |pair|
	vals = [pair.first.last, pair.last.last]
	y,z = vals.max, vals.min
	x = pair.first.first
	puts "checking #{x}, #{y}, #{z}"
	if (y-z).square? and (y+z).square?
	    puts "found!"
	    puts "#{x}, #{y}, #{z}"
	    puts x+y+z
	    exit
	end
    end
    puts n
    n += 1
end