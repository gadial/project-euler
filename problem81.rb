# In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in red and is equal to 2427.
# 
# 	
# 131	673	234	103	18
# 201	96	342	965	150
# 630	803	746	422	111
# 537	699	497	121	956
# 805	732	524	37	331
# 	
# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.


def path_min_sum(matrix, x,y)
	def inner(matrix,x,y)
		return matrix[x][y] if x==0 and y==0
		return matrix[x][y]+path_min_sum(matrix,x-1,y) if (x>0 and y==0)
		return matrix[x][y]+path_min_sum(matrix,x,y-1) if (x==0 and y>0)
		return matrix[x][y]+[path_min_sum(matrix,x-1,y),path_min_sum(matrix,x,y-1)].min
	end
	return $PathSums[x][y] unless $PathSums[x][y]==nil
	$PathSums[x][y]=inner(matrix,x,y)
	return $PathSums[x][y]
end

matrix = File.open("matrix.txt","r"){|file| file.read.split("\n").collect{|line| line.split(",").collect{|x| x.to_i}}}
# matrix = [[131,673,234,103,18],[201,96,342,965,150],[630,803,746,422,111],[537,699,497,121,956],[805,732,524,37,331]]
$PathSums=[]
matrix.length.times {$PathSums << [nil]*matrix.length}

puts path_min_sum(matrix,matrix.length-1,matrix.length-1)