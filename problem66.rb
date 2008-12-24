# Consider quadratic Diophantine equations of the form:

# x2 � Dy2 = 1

# For example, when D=13, the minimal solution in x is 6492 � 131802 = 1.

# It can be assumed that there are no solutions in positive integers when D is square.

# By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:

# 32 � 222 = 1
# 22 � 312 = 1
# 92 � 542 = 1
# 52 � 622 = 1
# 82 � 732 = 1

# Hence, by considering minimal solutions in x for D 7, the largest x is obtained when D=5.

# Find the value of D 1000 in minimal solutions of x for which the largest value of x is obtained

#in other words: x^2-1=Dy^2
#hence x^2-1 must be divisible by D and (x^2-1)/D must be square
require 'common'
require 'frac'
def gcd(x,y)
	return gcd(x.abs,y.abs) if x<0 or y<0
	return gcd(y,x) if x<y
	return x if y == 0
	return y if x % y == 0
	return gcd(y, x % y)
end

def gcd_3(x,y,z)
	gcd(gcd(x,y),z)
end

class FracWithSqrt
	attr_accessor :n, :numerator, :denominator, :a
	def initialize(numerator, denominator, n,a)
	# (a*sqrt(n)+numerator / denominator)
		self.n=n
		self.numerator = numerator
		self.denominator = denominator
		self.a = a
	end
	def value
		(self.n.sqrt + self.numerator) / self.denominator
	end
	def reciprocal
		abs = (self.a**2) * self.n - self.numerator**2
		FracWithSqrt.new(-self.numerator * self.denominator,abs,n,a*denominator).reduce
	end
	def to_s
		"(#{self.a}*sqrt(#{self.n})+#{self.numerator})/(#{self.denominator})"
	end
	def reduce
		d=gcd_3(self.a, self.numerator, self.denominator)
		FracWithSqrt.new(self.numerator / d, self.denominator / d, n, a / d)
	end
	def -(other)
		if Integer===other
			return FracWithSqrt.new(self.numerator-other*self.denominator,self.denominator,self.n,self.a).reduce
		end
		raise "don't know how to handle class #{other.class}"
	end
end


def continued_fraction_for_square_root(n)
	frac = FracWithSqrt.new(0,1,n,1)
	digits = []
	while true
		next_val = frac.value.floor
		digits << next_val
		break if frac.denominator == 1 and digits.length > 1 
# 		puts "#{frac}  ----- #{next_val}"
		frac = (frac - next_val).reciprocal
	end
	digits
end

class Integer
	def square?
		self == sqrt.to_i**2
	end
	def min_x_for_d_2
		return -1 if square? #should be nil, but can't perform "max" on array that contains nil
		x = 1
		while true
			x+=1
			t = x**2 - 1
			next unless t % self == 0
			return x if (t / self).square?
		end
	end
	def min_x_for_d
		return -1 if square? #should be nil, but can't perform "max" on array that contains nil
		y=0
		while true
			y+=1
			t = (self * y**2)+1
			return t.sqrt if t.square?
		end
	end
	def solve_pell
		#solves pell's equation x^2-self*y^2=1
		return -1 if square?
		temp = continued_fraction_for_square_root(self)
		initial_value = temp.shift
		temp=temp+temp if temp.length % 2 != 0
		temp.pop
		compute_continued_fraction(initial_value, temp).numerator
	end
end

def compute_continued_fraction(initial_value, description_array)
	description_array.reverse.inject(Frac.new(0,1)){|sum, x| (sum + x).reciprocal} + initial_value
end

# puts 61.solve_pell.inspect
t=(1..1000).collect {|d| puts "#{d}:#{d.to_f / 10}%"; d.solve_pell}
puts t.index(t.max)+1

