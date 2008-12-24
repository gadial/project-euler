# Triangle 	  	Tn=n(n+1)/2 	  	1, 3, 6, 10, 15, ...
# Pentagonal 	  	Pn=n(3n-1)/2 	  	1, 5, 12, 22, 35, ...
# Hexagonal 	  	Hn=n(2n-1) 	  	1, 6, 15, 28, 45, ...
# 
# It can be verified that T285 = P165 = H143 = 40755.
# 
# Find the next triangle number that is also pentagonal and hexagonal.
require 'common'

class Integer
	def triangle
		self*(self+1) / 2
	end
	def pentagonal
		self*(3*self - 1) / 2
	end
	def hexagonal
		self*(2*self - 1)
	end
	def pentagonal?
		n=((1+(1+24*self).sqrt) / 6).to_i
		self == (n*(3*n-1) / 2)
	end
	def triangle?
		n=(-1+(1+8*self).sqrt) / 2
		self == n*(n+1) / 2
	end
end

num = 50000

# triangles = (1..num).collect{|x| x.triangle}
# pentgaonals = (1..num).collect{|x| x.pentagonal}
hexagonals = (1..num).collect{|x| x.hexagonal}

puts hexagonals.find_all{|x| x.pentagonal? and x.triangle?}[2]