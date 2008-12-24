# A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly, F, sits in the opposite corner. By travelling on the surfaces of the room the shortest "straight line" distance from S to F is 10 and the path is shown on the diagram.
# 
# However, there are up to three "shortest" path candidates for any given cuboid and the shortest route is not always integer.
# 
# By considering all cuboid rooms up to a maximum size of M by M by M, there are exactly 2060 cuboids for which the shortest distance is integer when M=100, and this is the least value of M for which the number of solutions first exceeds two thousand; the number of solutions is 1975 when M=99.
# 
# Find the least value of M such that the number of solutions first exceeds one million.

#if the lengths of the cube are a>=b>=c then the shortest path is of length sqrt(a^2+b^2+c^2+2bc)
require 'common'
# $Squares = (1..500).collect{|x| x**2}
class Integer
	def square?
		self==(sqrt.to_i)**2
# 		$Squares.include?(self)
	end
end

def ways_to_represent(x, max)
	#number of ways to represent x as x=b+c with b<=c<=max
	return x / 2 if x<=max 		#(1,x-1),(2,x-2),...,(x-1,1)
	return ((2*max - x+1).to_f / 2).ceil if x>max	#(max,x-max),(max-1,x-max+1),...,(x-max, max)
end

def solutions_for_a(a)
	(2..2*a).find_all{|x| (a**2+x**2).square?}.collect{|x| ways_to_represent(x,a)}.sum
end
a=1
sum=0
while sum<10**6
	puts "#{a}, #{sum}"
	sum+=solutions_for_a(a)
	a+=1
end 
# def shortest_path_integer?(a,b,c)
# 	c,b,a = [a,b,c].sort
# 	(a**2+(b+c)**2).square?
# end
# 
# def shortest_path(a,b,c)
# 	c,b,a = [a,b,c].sort
# 	(a**2+b**2+c**2+2*b*c).sqrt
# end
# 
# max = 99
# sum = 0
# a=1
# while sum < 10**6
# 	puts "#{a}, #{sum}"
# 	(1..a).each do |b|
# 		(1..b).each do |c|
# 			sum += 1 if shortest_path_integer?(a,b,c)
# 		end
# 	end
# 	a += 1
# end
# 
# puts a
