require 'frac'
class Array
    def first_nonzero
	each_index{|i| return i if self[i] != 0}
	return length
    end
end
class Matrix
	attr_accessor :rows
	def initialize(rows)
		self.rows = rows
	end
	def Matrix.identity(n)
		temp_rows = []
		n.times do |i|
			temp_rows << [0]*n
			temp_rows.last[i] = 1
		end
		Matrix.new(temp_rows)
	end

	def collect!(&method)
		self.rows.collect!{|row| row.collect{|x| method.call(x)}}
		self
	end

	def collect(&method)
		dup.collect!(&method)
	end

	def to_frac_matrix!
		self.rows.collect!{|row| row.collect{|x| Frac[x]}}
		self
	end
	def to_frac_matrix
		dup.to_frac_matrix!
	end
	def dup
		Matrix.new(self.rows.collect{|row| row.dup})
	end
	def == (rhs)
		self.rows == rhs.rows
	end
	def height
		self.rows.length
	end
	def width
		self.rows.first.length
	end
	def is_square?
		height == width
	end
	def is_identity?
		return false unless is_square?
		self == Matrix.identity(height)
	end
	def column(j)
		case j
			when :last: j = width-1
			when :first: j = 0
		end
		
		result = []
		rows.each{|row| result << row[j].dup}
		return result
	end
	def submatrix(left, top, width, height)
		temp_rows = []
		height.times do |i|
			temp_rows << []
			width.times do |j|
				temp_rows.last << self.rows[top+i][left+j].dup		
			end
		end
		Matrix.new(temp_rows)
	end

	def add_column!(col, j = nil)
		j ||= self.rows.first.length
		col.each_index{|i| self.rows[i].insert(j,col[i])}
		self
	end
	def add_column(col, j = nil)
		dup.add_column!(col,j)
	end
	def switch_rows!(x,y)
		rows[x], rows[y] = rows[y], rows[x]
		self
	end

	def switch_rows(x,y)
		dup.switch_rows!(x,y)
	end

	def multiply_row!(i, a)
		self.rows[i].collect!{|x| x*a}
		self
	end

	def multiply_row(i,a)
		dup.multiply_row!(i,a)
	end

	def add_row_multiple!(i,j,a)
		temp_row = self.rows[i].collect{|x| x*a}
		temp_row.each_index {|k| self.rows[j][k] += temp_row[k]}
		self
	end

	def add_row_multiple(i,j,a)
		dup.add_row_multiple!(i,j,a)
	end

	def row_first_nonzero(row_num)
		row = rows[row_num]
		nonzero = row.find{|x| x != 0}
		return nil if nonzero == nil
		row.index(nonzero)
	end

	def row_reduce!
		self.rows.each_index do |i|
			j = row_first_nonzero(i)
			next if j == nil
			a = self.rows[i][j]
			multiply_row!(i,a.reciprocal)
			self.rows.each_index do |k|
				add_row_multiple!(i,k,self.rows[k][j]*(-1)) if k != i
			end
		end
		self
	end
	def row_reduce
		dup.row_reduce!
	end
	def sort_by_nonzeros!
	    rows.sort!{|a,b| a.first_nonzero <=> b.first_nonzero}
	    self
	end
	def sort_by_nonzeros
	    dup.sort_by_nonzeros!
	end
	def to_s
		self.rows.inject(""){|s, row| s+row.inspect+"\n"}
	end
end

def solve_linear_equation_system(a,b)
	#solves a*x=b
	raise "a.length = #{a.length} != b.length = #{b.length}" unless a.length == b.length
# 	puts Matrix.new(a).add_column(b)
	matrix = Matrix.new(a).add_column(b).row_reduce.sort_by_nonzeros
	if matrix.submatrix(0,0,matrix.width-1, matrix.height).is_identity?
		return matrix.column(:last)
	end
	return nil #no solution or infinite number of solutions
end