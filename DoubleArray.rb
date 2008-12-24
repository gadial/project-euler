class DoubleArray
	attr_reader :size_x, :size_y, :arr
	def initialize(size_x,size_y)
		@arr=Array.new(size_x*size_y)
		@size_x=size_x
		@size_y=size_y
	end
	def [](tx,ty)
		x,y=tx,ty
		offset=x+@size_x*y
		@arr[offset]
	end
	def []=(tx,ty,r)
		x,y=tx,ty
		offset=x+@size_x*y
		@arr[offset]=r
	end
	def each
		@size_y.times do |y|
			@size_x.times do |x|
				yield(@arr[x+@size_x*y])
			end
		end
	end
	def each_index
		@size_y.times do |y|
			@size_x.times do |x|
				yield([x,y])
			end
		end
	end
	def each_row
		@size_y.times do |i|
			yield(@arr[i*@size_x,@size_x])
		end	
	end
 	def find(&findFunc)
 		@arr.find(&findFunc)
 	end
	def find_all(&findFunc)
 		@arr.find_all(&findFunc)
 	end
	def each_in_range(from_x, from_y, to_x, to_y)
		to_x=to_x+@size_x if from_x>to_x
		to_y=to_y+@size_y if from_y>to_y
		from_x.upto(to_x) do |x|
			from_y.upto(to_y) do |y|
				yield([x % @size_x,y % @size_y])
			end
		end
	end
	def collect
		new_da=DoubleArray.new(self.size_x,self.size_y)
		new_da.each_index{|i,j| new_da[i,j]=yield(self[i,j])}
		new_da
	end
	def inspect
		output=String.new
		self.each_row{|x| output=output+x.inspect+"\n"}
		output
	end
end