# Three distinct points are plotted at random on a Cartesian plane, for which -1000 ≤ x, y ≤ 1000, such that a triangle is formed.
# 
# Consider the following two triangles:
# 
# A(-340,495), B(-153,-910), C(835,-947)
# 
# X(-175,41), Y(-421,-714), Z(574,-645)
# 
# It can be verified that triangle ABC contains the origin, whereas triangle XYZ does not.
# 
# Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text file containing the co-ordinates of one thousand "random" triangles, find the number of triangles for which the interior contains the origin.
# 
# NOTE: The first two examples in the file represent the triangles in the example given above.

#every point inside the triangle is a convex combination of the vertices
#so we want to solve a system of 2 variables and 2 equations:
#t1(x1-x3)+t2(x2-x3)=-x3
#t1(y1-y3)+t2(y2-y3)=-y3

require 'linear'

def contains_the_origin?(p1,p2,p3)
    a = [[p1[0]-p3[0],p2[0]-p3[0]],
	[p1[1]-p3[1],p2[1]-p3[1]]]
    b = [-p3[0],-p3[1]]
    result = solve_linear_equation_system(a,b)
#     puts "p1=#{p1.inspect}, p2=#{p2.inspect}, p3=#{p3.inspect}"
#     puts "a=#{a.inspect}, b=#{b.inspect}"
#     puts result.inspect
    result[0] > 0 and result [1] > 0 and (result[0]+result[1] < 1)
end

triangles = File.open("triangles.txt","r"){|file| file.read.split("\n").collect{|line| line.split(",").collect{|x| x.to_i}}}
puts triangles.find_all{|t| contains_the_origin?([t[0],t[1]],[t[2],t[3]],[t[4],t[5]])}.length