# All square roots are periodic when written as continued fractions and can be written in the form:
# It can be seen that the sequence is repeating. For conciseness, we use the notation 23 = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.
# 
# The first ten continued fraction representations of (irrational) square roots are:
# 
# 2=[1;(2)], period=1
# 3=[1;(1,2)], period=2
# 5=[2;(4)], period=1
# 6=[2;(2,4)], period=2
# 7=[2;(1,1,1,4)], period=4
# 8=[2;(1,4)], period=2
# 10=[3;(6)], period=1
# 11=[3;(3,6)], period=2
# 12= [3;(2,6)], period=2
# 13=[3;(1,1,1,1,6)], period=5
# 
# Exactly four continued fractions, for N 13, have an odd period.
# 
# How many continued fractions for N 10000 have an odd period?

require 'common'
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

max = 10000
puts (2..max).reject{|n| (n.sqrt.to_i)**2 == n}.collect{|n| continued_fraction_for_square_root(n).length - 1}.reject{|p| p % 2 ==0}.size
#  puts continued_fraction_for_square_root(10).inspect