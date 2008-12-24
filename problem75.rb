# It turns out that 12 cm is the smallest length of wire can be bent to form a right angle triangle in exactly one way, but there are many more examples.
# 
# 12 cm: (3,4,5)
# 24 cm: (6,8,10)
# 30 cm: (5,12,13)
# 36 cm: (9,12,15)
# 40 cm: (8,15,17)
# 48 cm: (12,16,20)
# 
# In contrast, some lengths of wire, like 20 cm, cannot be bent to form a right angle triangle, and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form exactly three different right angle triangles.
# 
# 120 cm: (30,40,50), (20,48,52), (24,45,51)
# 
# Given that L is the length of the wire, for how many values of L 2,000,000 can exactly one right angle triangle be formed?
require 'common'
def all_pairs(max_sum)
	results = []
	(1..max_sum).each {|i| (1..i).each {|j| results << [i,j]}}
	results
end

def primitive_pythagorean_triple(pair)
	s = pair.max
	t = pair.min
	[s**2 - t**2, 2*s*t, s**2 + t**2].sort
end



max = 2*(10**6)
# max = 200
triangle_numbers = [0]*max

primitive_triplets = all_pairs(1500).reject{|pair| pair.first.gcd(pair.last)!=1 or (pair.first.odd? and pair.last.odd?)}.collect{|pair| primitive_pythagorean_triple(pair)}.reject{|triple| triple.sum > max}

primitive_triplets.each do |triple|
	length = triple.sum
	temp = length
	while temp < max
		triangle_numbers[temp] += 1
		temp += length
	end
end

# puts triangle_numbers.inspect
puts triangle_numbers.reject{|x| x != 1}.length

