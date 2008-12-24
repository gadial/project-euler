# A triomino is a shape consisting of three squares joined via the edges. There are two basic forms:
# 
# If all possible orientations are taken into account there are six:
# 
# Any n by m grid for which nxm is divisible by 3 can be tiled with triominoes.
# If we consider tilings that can be obtained by reflection or rotation from another tiling as different there are 41 ways a 2 by 9 grid can be tiled with triominoes:
# 
# In how many ways can a 9 by 12 grid be tiled in this way by triominoes?


#We'll use a backtracking algorithm
require 'common'

def count_tilings(board_size_x, board_size_y, tile_set)
	def recurse(board, tile_set)
 		return 1 if board.empty? #filled the entire board
		count = 0
		tile_set.each do |tile|
			current_square = board.first
			next unless tile.forall {|s| board.include?([s[0]+current_square[0],s[1]+current_square[1]])}
			temp_board = board.dup
			tile.each{|s| temp_board.delete([s[0]+current_square[0],s[1]+current_square[1]])}
			count += recurse(temp_board,tile_set)
		end
		return count
	end

	board = []
	for i in 0...board_size_y
		for j in 0...board_size_x
			board << [i,j]
		end
	end
	board.sort
	recurse(board, tile_set)
end

tiles = [
		[[0,0],[0,1],[1,0]],
		[[0,0],[0,1],[0,2]],
		[[0,0],[1,0],[2,0]],
		[[0,0],[1,0],[1,1]],
		[[0,0],[0,1],[1,1]],
		[[0,0],[1,0],[1,-1]]
	]
puts count_tilings(9,12,tiles)