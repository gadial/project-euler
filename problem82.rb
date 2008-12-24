# NOTE: This problem is a more challenging version of Problem 81.
# 
# The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column and finishing in any cell in the right column, and only moving up, down, and right, is indicated in red; the sum is equal to 994.
# 
# 	
# 131	673	234	103	18
# 201	96	342	965	150
# 630	803	746	422	111
# 537	699	497	121	956
# 805	732	524	37	331
# 	
# 
# Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the left column to the right column.

def path_min_sum(matrix, x,y)
	def inner(matrix,x,y)
		return matrix[x][y] if x==0
		return matrix[x][y]+[path_min_sum(matrix,x-1,y),path_min_sum(matrix,x,y-1),path_min_sum(matrix,x,y+1)].reject{|x| x==nil}.min
	end
	return nil if (x<0 or y<0 or x>=matrix.length or y>=matrix.length)
	return $PathSums[x][y] unless $PathSums[x][y]==nil
	$PathSums[x][y]=inner(matrix,x,y)
	return $PathSums[x][y]
end

matrix = File.open("matrix.txt","r"){|file| file.read.split("\n").collect{|line| line.split(",").collect{|x| x.to_i}}}
$PathSums=[]
matrix.length.times {$PathSums << [nil]*matrix.length}

matrix.length.times {|y| $PathSums[y][0] = matrix[y][0]} #initial column
(1...matrix.length).each do |x|
	matrix.length.times {|y| $PathSums[y][x] = matrix[y][x]+$PathSums[y][x-1]} #trivial choice
	matrix.length.times do #we iterate until we're sure the "information" flowed from each row to each row
		matrix.length.times do |y|
			$PathSums[y][x]=matrix[y][x]+$PathSums[y-1][x] if (y>0 and matrix[y][x]+$PathSums[y-1][x] < $PathSums[y][x])
			$PathSums[y][x]=matrix[y][x]+$PathSums[y+1][x] if (y<matrix.length-1 and matrix[y][x]+$PathSums[y+1][x] < $PathSums[y][x])
		end
	end
end

puts (0...matrix.length).collect{|y| $PathSums[y][matrix.length-1]}.min