# The points P (x1, y1) and Q (x2, y2) are plotted at integer co-ordinates and are joined to the origin, O(0,0), to form ΔOPQ.
# 
# There are exactly fourteen triangles containing a right angle that can be formed when each co-ordinate lies between 0 and 2 inclusive; that is,
# 0 x1, y1, x2, y2 2.
# 
# Given that 0 x1, y1, x2, y2 50, how many right triangles can be formed?

def distance_squared(x1,y1,x2,y2)
	(x1-x2)**2+(y1-y2)**2
end

def is_right_triangle?(x1,y1,x2,y2)
	a,b,c = [distance_squared(0,0,x1,y1),distance_squared(0,0,x2,y2), distance_squared(x1,y1,x2,y2)].sort
	a + b == c and a != 0
end

max = 50
sum = 0
(0..max).each do |x1|
	puts x1
	(0..max).each do |y1|
		(0..max).each do |x2|
			(0..max).each do |y2|
				sum+=1 if is_right_triangle?(x1,y1,x2,y2)
			end
		end
	end
end

puts sum / 2