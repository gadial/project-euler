def gcd(x,y)
 	return gcd(x.abs,y.abs) if x<0 or y<0
	return gcd(y,x) if x.abs<y.abs
	return x if y == 0
	return y if x % y == 0
	return gcd(y, x % y)
end
def lcm(x,y)
	x*y / gcd(x,y)
end
class Integer
	def reciprocal
		Frac.new(1,self)
	end
end
class Frac
	include Comparable
	attr_accessor :numerator, :denominator
	def Frac.[](*params)
		if params.length == 1
			a = params.first
			return Frac.new(a,1) if Integer === a
			return Frac.new(a.numerator,a.denominator) if Frac === a
		end
		return Frac.new(params.first, params.last)
	end
	def initialize(numerator,denominator=1)
		raise "cannot divide by 0" if denominator==0
		self.numerator=numerator
		self.denominator=denominator
		if self.denominator < 0
		    self.denominator *= -1
		    self.numerator *= -1
		end
		reduce!
	end
	def denominator=(new_value)
		raise "cannot divide by 0" if new_value==0
		@denominator=new_value
	end
	def reduce
		current_gcd=gcd(self.numerator,self.denominator)
		Frac.new(self.numerator / current_gcd, self.denominator / current_gcd)
	end
	def reduce!
		current_gcd=gcd(self.numerator,self.denominator)
		self.numerator = self.numerator / current_gcd
		self.denominator = self.denominator / current_gcd
	end
	def to_s
		return "#{self.numerator}" if self.denominator==1
		"#{self.numerator}/#{self.denominator}"
	end
	def *(other)
		other = Frac.new(other,1) if Integer === other
		Frac.new(self.numerator*other.numerator, self.denominator*other.denominator)
	end
	def +(other)
		other = Frac.new(other,1) if Integer === other
		Frac.new(self.numerator*other.denominator+self.denominator*other.numerator, self.denominator*other.denominator)
	end
	def -(other)
		other = Frac.new(other,1) if Integer === other
		Frac.new(self.numerator*other.denominator-self.denominator*other.numerator, self.denominator*other.denominator)
	end
	def / (other)
		other = Frac.new(other,1) if Integer === other
		Frac.new(self.numerator*other.denominator, self.denominator*other.numerator)
	end
	def to_f
		self.numerator.to_f / self.denominator
	end
	def <=> (other)
		other = Frac.new(other,1) if Integer === other
		self.numerator*other.denominator <=> self.denominator*other.numerator		
	end
	def ** (exp)
	    Frac.new(numerator**exp, denominator**exp)
	end
	def reciprocal
		Frac.new(self.denominator, self.numerator)
	end
	def to_i
		to_f.to_i
	end
	def inspect
		to_s
	end
	def coerce(other)
		case other
			when Frac: return [other, self]
			when Integer: return [Frac.new(other), self]
			else raise "don't know how to coerce object of class #{other.class}"
		end
	end
	def eql?(rhs)
	    self == rhs
	end
	def hash
	    n = self.numerator + self.denominator - 2
	    (n*(n+1)) / 2 + self.denominator
	end
end
