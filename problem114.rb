# A row measuring seven units in length has red blocks with a minimum length of three units placed on it, such that any two red blocks (which are allowed to be different lengths) are separated by at least one black square. There are exactly seventeen ways of doing this.
# How many ways can a row measuring fifty units in length be filled?
# 
# NOTE: Although the example above does not lend itself to the possibility, in general it is permitted to mix block sizes. For example, on a row measuring eight units in length you could use red (3), black (1), and red (4).

#This problem calls for a simple dynamic programming solution, since we have an easy recurrence relation based on what we place
#on the first square. We can either place nothing and move to the next, or place a red block of size 3...n.

$Ways = []

def count_ways(n)
  return 1 if n < 1
  return $Ways[n] unless $Ways[n] == nil
  count = (3..n).inject(count_ways(n-1)){|sum, k| sum+count_ways(n-(k+1))}
  $Ways[n] = count
  return count
end
                                                                
puts count_ways(50)