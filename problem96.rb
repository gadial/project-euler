# Su Doku (Japanese meaning number place) is the name given to a popular puzzle concept. Its origin is unclear, but credit must be attributed to Leonhard Euler who invented a similar, and much more difficult, puzzle idea called Latin Squares. The objective of Su Doku puzzles, however, is to replace the blanks (or zeros) in a 9 by 9 grid in such that each row, column, and 3 by 3 box contains each of the digits 1 to 9. Below is an example of a typical starting puzzle grid and its solution grid.
# 
# A well constructed Su Doku puzzle has a unique solution and can be solved by logic, although it may be necessary to employ "guess and test" methods in order to eliminate options (there is much contested opinion over this). The complexity of the search determines the difficulty of the puzzle; the example above is considered easy because it can be solved by straight forward direct deduction.
# 
# The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'), contains fifty different Su Doku puzzles ranging in difficulty, but all with unique solutions (the first puzzle in the file is the example above).
# 
# By solving all fifty puzzles find the sum of the 3-digit numbers found in the top left corner of each solution grid; for example, 483 is the 3-digit number found in the top left corner of the solution grid above.

class Sudoku
    attr_reader :squares
    def initialize(s)
    	case s
		when String: @squares = s.split("\r\n").collect{|line| line.split("").collect{|x| x.to_i}}
		when Sudoku: @squares = s.squares.collect{|line| line.dup}
	end
    end
    def dup
    	Sudoku.new(self)
    end
    def [](x,y)
	return @squares[x][y] if Integer === x
	case x
	when :row: return row(y)
	when :column: return column(y)
	when :square: return square(y)
	end
    end
    def []=(x,y,val)
	case x
	when Integer: @squares[x][y]=val
	when :row: return set_row(y,val)
	when :column: return set_column(y,val)
	when :square: return set_square(y,val)
	end

    end
    def row(i)
	result = []
	9.times {|j| result << @squares[i][j]}
	return result
    end
    def set_row(i,new_row)
	result = []
	9.times {|j| @squares[i][j] = new_row[j]}
    end
    def column(j)
	result = []
	9.times {|i| result << @squares[i][j]}
	return result
    end
    def set_column(j, new_column)
	result = []
	9.times {|i| @squares[i][j] = new_column[i]}
    end
    def square(t)
	result = []
	x = (t / 3) * 3
	y = (t % 3) * 3 
	(x...x+3).each {|i| (y...y+3).each {|j| result << @squares[i][j]}}
	return result
    end
    def set_square(t, new_square)
	result = []
	temp = new_square.dup
	x = (t / 3) * 3
	y = (t % 3) * 3 
	(x...x+3).each {|i| (y...y+3).each {|j| @squares[i][j] = temp.shift}}
    end
    def row_of(i,j)
	row(i)
    end
    def column_of(i,j)
	column(j)
    end
    def square_of(i,j)
	square(3*(i / 3) + (j / 3))
    end
    def to_s
	s = "Sudoku board\n"
	9.times do |i|
	    9.times do |j|
		s += self[i,j].to_s
		s += "|" if j == 2 or j == 5
	    end
	    s+="\n"
	    s+="===========\n" if i == 2 or i == 5
	end
	return s
    end
    def remaining(numbers)
	(1..9).to_a - numbers
    end
    def allowed_values(i,j)
	return [] if self[i,j] != 0
	(1..9).to_a - (row_of(i,j) + column_of(i,j) + square_of(i,j))
    end
    def each_square
	9.times {|i| 9.times {|j| yield(i,j)}}
    end
    def set_square_with_message(i,j,val,message)
	self[i,j] = val
# 	if message == "guess"
# 	    puts "putting #{val} at (#{i},#{j}): " + message + " (#{unsolved_squares} squares remaining)"
# 	    puts self
# 	end
    end
    def basic_elimination
	changes = true
	while changes
	    changes = false
	    each_square do |i,j|
		return :board_contradictory if self[i,j] == 0 and allowed_values(i,j).length == 0
		if self[i,j] == 0 and allowed_values(i,j).length == 1
		    set_square_with_message(i,j,allowed_values(i,j).first,"basic elimination")
		    changes = true
		end #if
	    end #each
	end #while 
	return self
    end
    def square_coords_to_real_coords(t,r)
	[(t / 3) * 3 + (r / 3),(t % 3) * 3 + (r % 3)]
    end
    def basic_nessacity
	changes = true
	while changes
	    changes = false
	    each_square do |i,j|
		must = []
		must += remaining(row_of(i,j)) if remaining(row_of(i,j)).length == 1
		must += remaining(column_of(i,j)) if remaining(column_of(i,j)).length == 1
		must += remaining(square_of(i,j)) if remaining(square_of(i,j)).length == 1
# 		return :board_contradictory if must.length > 1
		if self[i,j] == 0 and must.length == 1 and allowed_values(i,j).include?(must.first)
		    set_square_with_message(i,j,must.first,"basic nessacity")
		    changes = true
		end #if
	    end #each
	end #while 
	return self
    end
    def column_nessacity
	9.times do |j|
	    ((1..9).to_a - self[:column, j]).each do |needed_value|
		possible_squares = (0..8).find_all{|i| allowed_values(i,j).include?(needed_value)}
		if possible_squares.length == 1
		    i = possible_squares.first
		    set_square_with_message(i,j,needed_value,"column nessacity")
		end
	    end
	end
    end
    def row_nessacity
	9.times do |i|
	    ((1..9).to_a - self[:row, i]).each do |needed_value|
		possible_squares = (0..8).find_all{|j| allowed_values(i,j).include?(needed_value)}
		if possible_squares.length == 1
		    j = possible_squares.first
		    set_square_with_message(i,j,needed_value,"row nessacity")
		end
	    end
	end
    end
    def square_nessacity
	9.times do |t|
	    ((1..9).to_a - self[:square, t]).each do |needed_value|
		possible_squares = (0..8).find_all{|r| allowed_values(*square_coords_to_real_coords(t,r)).include?(needed_value)}
		if possible_squares.length == 1
		    r = possible_squares.first
		    set_square_with_message(square_coords_to_real_coords(t,r).first,square_coords_to_real_coords(t,r).last,needed_value,"square nessacity")
		end
	    end
	end
    end
    def vector_legal?(vector)
    	(vector - [0]).uniq.length == (vector - [0]).length
    end
    def legal?
    	9.times do |i|
    		[:row, :column, :square].each{|current_vector| return false unless vector_legal?(self[current_vector, i])}
    	end
    	return true
    end
    def include?(x)
	each_square{|i,j| return true if self[i,j] == x}
	return false
    end
    def solved?
	legal? and not include?(0)
    end
    def unsolved_squares
	sum = 0
	each_square{|i,j| sum += 1 if self[i,j] == 0}
	return sum
    end
    def find_first_nonsolved
    	each_square {|i,j| return [i,j] if self[i,j] == 0}
    end
    def find_min_nonsolved
	min = 10
	current = nil
	each_square do |i,j|
	    if self[i,j] == 0 and allowed_values(i,j).length < min
		current = [i,j]
		min = allowed_values(i,j).length
	    end
	end
	return current
    end
    def guess
	i,j = find_min_nonsolved
	possible_values = allowed_values(i,j)
	good_value = possible_values.find do |val| 
		temp_board = dup
		temp_board.set_square_with_message(i,j,val,"guess")
		temp_board.solve if temp_board.legal?
		temp_board.solved?
	end
	if good_value != nil
	    self[i,j] = good_value 
	    solve if not solved?
	end
    end
    def solve
	old = 0
	new = unsolved_squares
	while new != old
	    basic_elimination
	    basic_nessacity
	    column_nessacity
 	    row_nessacity
 	    square_nessacity
	    old, new = new, unsolved_squares
	end
	#time to guess
 	guess if legal? and not solved?
	return self
    end
    def upper_left_number
	100*self[0,0]+10*self[0,1]+self[0,2]
    end
end

boards = File.open("sudoku.txt","r"){|file| file.read.split(/Grid.*\n/).reject{|s| s==""}}.collect{|s| Sudoku.new(s)}
boards.each_index{|i| puts "solving board #{i}"; boards[i].solve}
puts boards.inject(0){|sum, b| sum+b.upper_left_number}                                                                