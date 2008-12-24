# If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
# 
# {20,48,52}, {24,45,51}, {30,40,50}
# 
# For which value of p 1000, is the number of solutions maximised?

#go over all a,b such that a<b and a+b+c<1000, where c^2=a^2+b^2
#then a+b+c>sqrt(2)a+a+b>2a+b
#therefore, a<(1000-b) / 2
require 'common'
results = [0]*1000 #results[p]=number of solutions for p
(1..500).each do |a|
	(1..a).each do |b|
		c = (a**2+b**2).sqrt.to_i
 		results[a+b+c] += 1 if (a**2+b**2==c**2) and (a+b+c < 1000)
	end
end

puts results.index(results.max)