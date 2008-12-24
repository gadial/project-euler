# Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.
# 
# If we list the set of reduced proper fractions for d 8 in ascending order of size, we get:
# 
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# 
# It can be seen that 2/5 is the fraction immediately to the left of 3/7.
# 
# By listing the set of reduced proper fractions for d 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.

require 'frac'

class Integer
	def closest_multiple(mul)
		rem = self % mul
		return ((rem < mul - rem)?(self - rem):(self + (mul-rem)))
	end
end

class Frac
	def best_approx(d)
		#finds t/d such that t/d is closest to self
		lcm_val=lcm(d,denominator)
		common_denominator_multiplier = lcm_val / denominator
		Frac.new((self.numerator*lcm_val / self.denominator).closest_multiple(lcm_val / d),lcm_val)
	end
end

t=Frac.new(3,7)
approximations = (2..10**6).collect{|d| t.best_approx(d)}.collect{|x| (x>t)?(Frac.new(x.numerator-1,x.denominator)):(x)}.reject{|x| x==t}
puts approximations.max
# puts Frac.new(3,7).best_approx(8)