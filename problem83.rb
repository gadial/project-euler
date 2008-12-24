# NOTE: This problem is a significantly more challenging version of Problem 81.
# 
# In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left, right, up, and down, is indicated in red and is equal to 2297.
# 
# 	
# 131	673	234	103	18
# 201	96	342	965	150
# 630	803	746	422	111
# 537	699	497	121	956
# 805	732	524	37	331
# 	
# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by moving left, right, up, and down.

#we'll use Dijkstra's algorithm
class Array
	def neighbors
		x = self.last
		y = self.first
		result = []
		result << [y,x-1] unless x<=0
		result << [y-1,x] unless y<=0
		result << [y,x+1] unless x>=$Matrix.length-1
		result << [y+1,x] unless y>=$Matrix.length-1
# 		puts "neighbors for #{self.inspect}: #{result.inspect}"
		return result
	end
end

def update_values(n,current,known_partial_values)
	new_value = known_partial_values[current] + $Matrix[n.first][n.last]
	known_partial_values[n] = new_value if (known_partial_values[n] == nil or known_partial_values[n] > new_value)
end

$Matrix = File.open("matrix.txt","r"){|file| file.read.split("\n").collect{|line| line.split(",").collect{|x| x.to_i}}}
$PathSums=[]
$Matrix.length.times {$PathSums << [nil]*$Matrix.length}

not_visited = []
$Matrix.length.times {|x| $Matrix.length.times {|y| not_visited << [y,x]}}
current = [0,0]
known_partial_values = {current => $Matrix[0][0]}
while not not_visited.empty?
	not_visited.delete(current)
 	puts "nodes remaining: #{not_visited.length}. Current node: #{current}"
	x = current.last
	y = current.first
	current.neighbors.find_all{|n| not_visited.include?(n)}.each {|n| update_values(n, current, known_partial_values)}
	$PathSums[y][x] = known_partial_values[current]
	known_partial_values.delete(current)
	current = known_partial_values.min{|a,b| a[1] <=> b[1]}.first unless not_visited.empty?
end

puts $PathSums[$Matrix.length-1][$Matrix.length-1]
