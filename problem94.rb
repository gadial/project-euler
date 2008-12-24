# It is easily proved that no equilateral triangle exists with integral length sides and integral area. However, the almost equilateral triangle 5-5-6 has an area of 12 square units.
# 
# We shall define an almost equilateral triangle to be a triangle for which two sides are equal and the third differs by no more than one unit.
# 
# Find the sum of the perimeters of every almost equilateral triangle with integral side lengths and area and whose perimeters do not exceed one billion (1,000,000,000).

#if we have a (a,a,a+1) triangle, it's area (by Heron's formula) is (a+1) / 4 * sqrt(3a^2-2a-1)
#hence we are interested in squares of the form 3a^2-2a-1.
require 'common'
def solve_equation(a,b,c)
	(-b + (b**2 - 4*a*c).sqrt) / (2*a)
end
class Integer
	def is_ok?
		a = solve_equation(3,-2,-1-self).to_i
		self == 3*a**2-2*a-1 
	end
	def is_ok_2?
		a = solve_equation(3,8,4-self).to_i
		self == 3*a**2+8*a+4
	end
	def is_really_ok?
		a = solve_equation(3,-2,-1-self).to_i
		sq = sqrt.to_i
		(a+1)*sq % 4 == 0 and a != 0
	end
	def is_really_ok_2?
		a = solve_equation(3,8,4-self).to_i
		sq = sqrt.to_i
 		(a*sq) % 4 == 0 and a != 0
	end
	def area
		a = solve_equation(3,-2,-1-self).to_i
		sq = sqrt.to_i
		(a+1)*sq / 4 
	end
	def perimeter
		a = solve_equation(3,-2,-1-self).to_i
		3*a+1
	end
	def perimeter_2
		a = solve_equation(3,8,4-self).to_i
		3*a+2
	end
	def triangle_2
		a = solve_equation(3,8,4-self).to_i
		[a,a+1,a+1]
	end
end

def heron_formula(a,b,c)
	s=(a+b+c) / 2
	(s*(s-a)*(s-b)*(s-c)).integer_sqrt
end

max = 10**9
# squares = (1..10**6).collect{|x| x**2}
# x=squares.find_all{|s| s.is_ok?}.find_all{|s| s.is_really_ok?}.collect{|s| s.perimeter}.sum
# y=squares.find_all{|s| s.is_ok_2?}.find_all{|s| s.is_really_ok_2?}.collect{|s| s.perimeter_2}.sum
# puts x+y

# puts squares.find_all{|s| s.is_ok_2?}.find_all{|s| s.is_really_ok_2?}.collect{|s| s.triangle_2}.inspect

# puts heron_formula(240,241,241)


# puts (1..100000).find_all{|k| (k % 3 != 2) and (k*(k+2) / 3).square?}.inspect
def f(x)
	3*x**2+4*x+1
end

def a_from_t(t)
  #t satisfies 3t^2+1 is square
  2*(-1+(3*t**2+1).integer_sqrt) / 3 + 1
end

def count_qr(x)
  (0...x).collect{|a| (a**2) % x}.uniq.length
end
m_vector = [55,91,144,437]

b_m = m_vector.prod
y_vector = m_vector.collect{|m_i| t=(b_m / m_i); t*t.inverse_modulo(m_i)}

qr_vector = m_vector.collect do |m| 
  qr=(0...m).collect{|a| (a**2) % m}.uniq.sort
  (0...m).find_all{|x| qr.include?(f(x) % m)}
end

# result = []
# i=0
# for x1 in qr_vector[0]
#   for x2 in qr_vector[1]
#     for x3 in qr_vector[2]
#       for x4 in qr_vector[3]
# 	i+=1
# 	num = chinese_remainder_theorem([x1,x2,x3,x4],m_vector,y_vector)
#  	puts i
# 	result << (2*num) if f(num).square?
#       end
#     end
#   end
# end
# puts result.inspect

# possible_results = [1, 5, 12545, 901, 174725, 33895685, 65, 472105985, 2433601]
possible_results = [0, 652080, 16, 240, 3360, 9082320, 46816, 126500416]
puts possible_results.collect{|a| heron_formula(a,a+1,a+1)}.inspect
real_results_a = [5, 12545, 901, 174725, 33895685, 65, 472105985, 2433601] #a, a, a+1
real_results_b = [652080, 16, 240, 3360, 9082320, 46816, 126500416] #a, a+1, a+1

puts real_results_a.collect{|a| 3*a+1}.reject{|x| x>max}.sum + real_results_b.collect{|a| 3*a+2}.reject{|x| x>max}.sum





# qr_vector.each{|x| puts x.inspect}

# primes = [2,3,5,7,11,13,17,19,23,29]
# 
# residues = primes.collect do |p|
# 	qr=(0...p).collect{|a| (a**2) % p}.uniq.sort
# 	(0...p).find_all{|x| qr.include?(f(x) % p)}
# end
# 
# puts residues.collect{|r| r.length}.prod
# puts (1..100000).find_all{|x| f(x).square?}.inspect
# a=a_from_t(40545)
# puts "a=#{a}, area=#{heron_formula(a,a,a+1)}"

# puts (1..200).collect{|x| [x, count_qr(x)]}.sort{|a,b| (b[0] / b[1]) <=> (a[0] / a[1])}.inspect
# puts count_qr(29*31)
# puts count_qr(144)*count_qr(55)*count_qr(91)*count_qr(23*29)