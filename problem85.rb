# By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains eighteen rectangles:
# 
# Although there exists no rectangular grid that contains exactly two million rectangles, find the area of the grid with the nearest solution.
require 'common'
def all_pairs(max_x, max_y)
	results = []
	(1..max_x).each {|x| (1..max_y).each {|y| results << [x,y]}}
	results
end

def rectangles_in_grid(x,y)
	all_pairs(x,y).collect{|pair| (x-pair[0]+1)*(y-pair[1]+1)}.sum
end

target = 2*10**6

puts all_pairs(100,100).collect{|pair| x=pair[0]; y=pair[1]; puts "(#{x},#{y})"; [x*y, (target-rectangles_in_grid(x,y)).abs]}.min{|a,b| a[1] <=> b[1]}.inspect