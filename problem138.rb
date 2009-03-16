# Consider the isosceles triangle with base length, b = 16, and legs, L = 17.
# 
# By using the Pythagorean theorem it can be seen that the height of the triangle, h = √(17^(2) − 8^(2)) = 15, which is one less than the base length.
# 
# With b = 272 and L = 305, we get h = 273, which is one more than the base length, and this is the second smallest isosceles triangle with the property that h = b ± 1.
# 
# Find ∑ L for the twelve smallest isosceles triangles for which h = b ± 1 and b, L are positive integers.

#if h=b+1 then set x = L and y = b / 2 (b must be even, otherwise h won't be, and so b won't be) and we have x^2=y^2+(2y+1)^2
#so we're interested in generating Pythagorean triplets of the form (2y+1,y,x) with y even
#such a triplet must be primitive, since gcd(y,2y+1) = 1
#hence there are s,t such that:
#1) 2y+1 = s^2-t^2
#2) y = 2st
#substitue (2) in (1) to get s^2-t^2=4st+1
#from which we derive the Pell equation (s-2t)^2-5t^2 = 1
#conclusion: for each solution of X^2-5Y^2 = 1
#we find t=Y, s = X+2Y
#and hence y=2Y(X+2Y)
#and hence b = 4Y(X+2Y)
#and L = s^2+t^2 = (X+2Y)^2+Y^2

#for h=b-1 we have almost the same thing, but end up with X^2-5Y^2 = -1
#so we start with the fundemental solution of X^2-5Y^2 = -1 (which is x=2,y=1) instead of X^2-5Y^2 = 1


require 'common'
def generate_pell_solutions(n,x,y, max)
    #x,y is the fundemental solution for x^2-ny^2=1
    solutions = [[x,y]]
    current_x, current_y = x,y
    (max-1).times do
        current_x, current_y = x*current_x + n*y*current_y, x*current_y+y*current_x
        solutions << [current_x, current_y]
    end
    return solutions
end

max = 12
sol = generate_pell_solutions(5,2,1,12)
sol = sol.collect do |pair|
	x,y = pair.first, pair.last
	b = 4*y*(x+2*y)
	l = (x+2*y)**2+y**2
	perimeter = 2*l+b
	[perimeter,l]
end.sort.collect{|pair| pair.last}

puts sol.sum