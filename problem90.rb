# Each of the six faces on a cube has a different digit (0 to 9) written on it; the same is done to a second cube. By placing the two cubes side-by-side in different positions we can form a variety of 2-digit numbers.
# 
# For example, the square number 64 could be formed:
# 
# In fact, by carefully choosing the digits on both cubes it is possible to display all of the square numbers below one-hundred: 01, 04, 09, 16, 25, 36, 49, 64, and 81.
# 
# For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on one cube and {1, 2, 3, 4, 8, 9} on the other cube.
# 
# However, for this problem we shall allow the 6 or 9 to be turned upside-down so that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} allows for all nine square numbers to be displayed; otherwise it would be impossible to obtain 09.
# 
# In determining a distinct arrangement we are interested in the digits on each cube, not the order.
# 
# {1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}
# {1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}
# 
# But because we are allowing 6 and 9 to be reversed, the two distinct sets in the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9} for the purpose of forming 2-digit numbers.
# 
# How many distinct arrangements of the two cubes allow for all of the square numbers to be displayed?

class Array
	def all_subsets(size)
		return [[]] if size == 0
		result = []
		each {|x| result += (self-[x]).all_subsets(size - 1).collect{|t| t << x}}
		result.collect{|x| x.sort}.uniq
	end
end

def cubes_can_create_goal(cube1, cube2, goals)
	goals.each do |goal|
		x,y = goal.split("")
		return false unless (cube1.include?(x) and cube2.include?(y)) or (cube1.include?(y) and cube2.include?(x))
	end
	true
end

def extended_cube(cube)
	return cube.push("9").uniq if cube.include?("6")
	return cube.push("6").uniq if cube.include?("9")
	cube
end

possible_cubes = ["1","2","3","4","5","6","7","8","9","0"].all_subsets(6)
goal_numbers = ["01", "04", "09", "16", "25", "36" ,"49", "64", "81"]
count = 0
possible_cubes.each do |cube1|
	cube1 = extended_cube(cube1)
	possible_cubes.each do |cube2|
		cube2 = extended_cube(cube2)
		count += 1 if cubes_can_create_goal(cube1,cube2,goal_numbers)
	end
end

puts count / 2
