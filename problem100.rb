# If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)(14/20) = 1/2.
# 
# The next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box containing eighty-five blue discs and thirty-five red discs.
# 
# By finding the first arrangement to contain over 1012 = 1,000,000,000,000 discs in total, determine the number of blue discs that the box would contain.

#can be reduced to the pell-like equation 2y^2-x^2=1
#with a=2y-1, b=2x-1
require 'common'
max = 10**12
def solve_pell_equation(n, x1, y1)
#     given the fundemental solution (x1,y1) satisfying |(x1+sqrt(n)y1|=1, finds the other solutions
    x,y = x1, y1
    while true
	yield(x,y)
	x,y = (x1*x+n*y1*y), (x1*y+y1*x)
    end
end

solve_pell_equation(2,1,1) do |x,y|
    a,b = (y+1) / 2, (x+1) / 2
    if 2*y**2-x**2 == 1
	    if b > max
		    puts a
		    break
	    end
    end
end

