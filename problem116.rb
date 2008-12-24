# A row of five black square tiles is to have a number of its tiles replaced with coloured oblong tiles chosen from red (length two), green (length three), or blue (length four).
# 
# If red tiles are chosen there are exactly seven ways this can be done.
# If green tiles are chosen there are three ways.
# And if blue tiles are chosen there are two ways.
# Assuming that colours cannot be mixed there are 7 + 3 + 2 = 12 ways of replacing the black tiles in a row measuring five units in length.
# 
# How many different ways can the black tiles in a row measuring fifty units in length be replaced if colours cannot be mixed and at least one coloured tile must be used?

#like the previous problems - again, we use dynamic programming

$Vals = {}
def F(m,n)
  #length n, color of size m
  #also counts the "global" situation where no tiles were placed, so subtract 1 at the end
    return 0 if n < 0
    return 1 if n <= 1
    return $Vals[[m,n]] unless $Vals[[m,n]] == nil
    count = F(m,n-1)+F(m,n-m)
    $Vals[[m,n]] = count
    return count
end

n = 50
tiles = [2,3,4]
puts tiles.inject(0){|sum, m| sum+F(m,n)-1}