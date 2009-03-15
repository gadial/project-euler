# Let (a, b, c) represent the three sides of a right angle triangle with integral length sides. It is possible to place four such triangles together to form a square with length c.
# 
# For example, (3, 4, 5) triangles can be placed together to form a 5 by 5 square with a 1 by 1 hole in the middle and it can be seen that the 5 by 5 square can be tiled with twenty-five 1 by 1 squares.
# 
# However, if (5, 12, 13) triangles were used then the hole would measure 7 by 7 and these could not be used to tile the 13 by 13 square.
# 
# Given that the perimeter of the right triangle is less than one-hundred million, how many Pythagorean triangles would allow such a tiling to take place?

require 'common'

max = 100*10**6
count = 0
s = 2
while 2*s**2 < max
    puts s
    t = 0
    while t< s and 2*s*(s+t) < max
	t += 1
	next if s.gcd(t) != 1 or (s.odd? and t.odd?)
	temp = ((s-t)**2 - 2*t**2).abs
	if (s**2+t**2) % temp == 0
	    perimeter = 2*s*(s+t)
	    count += (max / perimeter)
	end
    end
    s += 1
end

puts count