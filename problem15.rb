# Starting in the top left corner of a 2x2 grid, there are 6 routes (without backtracking) to the bottom right corner.
# 
# How many routes are there through a 20x20 grid?

grid_size=20
#a simple formula: (n+k-1 \choose k)

def choose(n,k)
	(0...k).inject(1){|prod, i| prod*(n-i).to_f / (k-i)}.to_s.to_i
end

def choice_with_repetitions(n,k)
	choose(n+k-1,k)
end

puts choice_with_repetitions(grid_size+1,grid_size)