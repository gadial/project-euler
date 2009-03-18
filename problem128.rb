# A hexagonal tile with number 1 is surrounded by a ring of six hexagonal tiles, starting at "12 o'clock" and numbering the tiles 2 to 7 in an anti-clockwise direction.
# 
# New rings are added in the same fashion, with the next rings being numbered 8 to 19, 20 to 37, 38 to 61, and so on. The diagram below shows the first three rings.
# 
# By finding the difference between tile n and each its six neighbours we shall define PD(n) to be the number of those differences which are prime.
# 
# For example, working clockwise around tile 8 the differences are 12, 29, 11, 6, 1, and 13. So PD(8) = 3.
# 
# In the same way, the differences around tile 17 are 1, 17, 16, 1, 11, and 10, hence PD(17) = 2.
# 
# It can be shown that the maximum value of PD(n) is 3.
# 
# If all of the tiles for which PD(n) = 3 are listed in ascending order to form a sequence, the 10th tile would be 271.
# 
# Find the 2000th tile in this sequence.
require 'common'
require 'miller-rabin'
#possible to see that the only potential hexagons are the ones in direct line upward from 1, and the ones adjacent to them on the lower right
#from this we deduce that for every n:
#1) if (6n-1),(6n+1) and (12n+5) are prime, 3n(n-1)+2 is in.
#2) if (6n+5),(6n-1),(12n-7) are prime, 3n(n+1)+1 is in (except 7)
max = 2000
results = [1]
n = 1
while results.length < max
    results << 3*n*(n-1)+2 if (6*n+1).prime? and (6*n-1).prime? and (12*n+5).prime?
    results << 3*n*(n+1)+1 if (6*n+5).prime? and (6*n-1).prime? and (12*n-7).prime? and n != 1
    n += 1
    puts results.length
end

puts results.last
