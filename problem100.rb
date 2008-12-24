# If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)(14/20) = 1/2.
# 
# The next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box containing eighty-five blue discs and thirty-five red discs.
# 
# By finding the first arrangement to contain over 1012 = 1,000,000,000,000 discs in total, determine the number of blue discs that the box would contain.

# We want to find integer a<b satisfying:
# a(a-1)/b(b-1) = 1 / 2
# i.e. 2a^2-2a-(b^2-b) = 0
# with b>10^12

#this can be reduced to the equation x^2-2y^2 = 32
#with a = (x+8) / 16, b = (y+4) / 8

require 'common'
def solve_equation_in_integers(a,b,c)
      dis = (b**2 - 4*a*c).integer_sqrt
      return ((dis != nil and ((-b + dis) % (2*a) == 0))?((-b + dis) / (2*a)):(nil))
end

class Integer
  def find_a
    solve_equation_in_integers(2,-2,-self*(self-1))
  end
end


min = 10**12

b = min

to_check = 2*b**2 - 2*b + 1

counter = 0
start_time = Time.new
while not to_check.square?
	puts "#{counter}, #{Time.new - start_time}" if counter % 10**5 == 0
	to_check += 4*(b+counter)
	counter += 1
end

puts b

# 
# b = 10**12
# while b.find_a == nil
#   b += 1
#   puts b
# end

puts b.find_a

# def f(x)
# 	2*x**2-2*x+1
# end
# primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43]
# 
# residues = primes.collect do |p|
# 	qr=(0...p).collect{|a| (a**2) % p}.uniq.sort
# 	(0...p).find_all{|x| qr.include?(f(x) % p)}
# end
# 
# puts residues.collect{|r| r.length}.prod
# puts min