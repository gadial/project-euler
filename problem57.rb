# It is possible to show that the square root of two can be expressed as an infinite continued fraction.
# 
# 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
# 
# By expanding this for the first four iterations, we get:
# 
# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
# 
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.
# 
# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?
require 'common'
def gcd(x,y)
	return gcd(y,x) if x<y
	return y if x % y == 0
	return gcd(y, x % y)
end

class Frac
	attr_accessor :numerator, :denominator
	def initialize(numerator,denominator=1)
		raise "cannot divide by 0" if denominator==0
		self.numerator=numerator
		self.denominator=denominator
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
	def==(other)
		self.numerator*other.denominator == self.denominator*other.numerator
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
	def reciprocal
		Frac.new(self.denominator, self.numerator)
	end
	def inspect
		to_s
	end
end

expansion_num=1000
expansions = [Frac.new(1,2)+1]
expansion_num.times do |i|
	expansions[i+1]=(expansions[i]+1).reciprocal+1
end

puts expansions.find_all{|x| x.numerator.digits.length > x.denominator.digits.length}.length