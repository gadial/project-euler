# The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
# 
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
# 
# There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.
# 
# If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
require 'common'
def gcd(x,y)
	return gcd(y,x) if x<y
	return y if x % y == 0
	return gcd(y, x % y)
end

class Integer
	def erase_digits(digits_to_erase)
		#erases the first occurence of digit
                temp = self.digits
		digits_to_erase.each do |digit|
                  raise "digit not decimal" if digit >9
                  temp.delete_at(temp.index(digit)) if temp.include?(digit)
		end
                return temp.join("").to_i
	end
end

class Frac
	attr_accessor :numerator, :denominator
	def initialize(numerator,denominator=1)
		raise "cannot divide by 0" if denominator==0
		self.numerator=numerator
		self.denominator=denominator
	end
	def denominator=(new_value)
		raise "cannot divide by 0" if new_value==0
		@denominator=new_value
	end
	def reduce
		current_gcd=gcd(self.numerator,self.denominator)
		Frac.new(self.numerator / current_gcd, self.denominator / current_gcd)
	end
	def to_s
		return "#{self.numerator}" if self.denominator==1
		"#{self.numerator}/#{self.denominator}"
	end
	def==(other)
		self.numerator*other.denominator == self.denominator*other.numerator
	end
	def equal_representation(other)
		self.numerator == other.numerator and self.denominator == other.denominator
	end
	def unorthodox_reduce
		common_digits=self.numerator.digits & self.denominator.digits
		temp_numerator = (self.numerator.erase_digits(common_digits))
		temp_denominator = (self.denominator.erase_digits(common_digits))
		return Frac.new(1) if temp_denominator == 0
		Frac.new(temp_numerator,temp_denominator)
	end
	def *(other)
		Frac.new(self.numerator*other.numerator, self.denominator*other.denominator)
	end
end


results = []
(10..99).each do |denominator|
	(10..denominator-1).each do |numerator|
		temp = Frac.new(numerator,denominator)
		results << temp if temp.unorthodox_reduce == temp and not temp.unorthodox_reduce.equal_representation(temp)
	end
end

puts results.reject{|f| f.numerator % 10 == 0 and f.denominator % 10 == 0}.inject(Frac.new(1)){|prod, x| prod*x}.reduce