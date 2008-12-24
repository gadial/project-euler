# NOTE: This is a more difficult version of problem 114.
# 
# A row measuring n units in length has red blocks with a minimum length of m units placed on it, such that any two red blocks (which are allowed to be different lengths) are separated by at least one black square.
# 
# Let the fill-count function, F(m, n), represent the number of ways that a row can be filled.
# 
# For example, F(3, 29) = 673135 and F(3, 30) = 1089155.
# 
# That is, for m = 3, it can be seen that n = 30 is the smallest value for which the fill-count function first exceeds one million.
# 
# In the same way, for m = 10, it can be verified that F(10, 56) = 880711 and F(10, 57) = 1148904, so n = 57 is the least value for which the fill-count function first exceeds one million.
# 
# For m = 50, find the least value of n for which the fill-count function first exceeds one million.

$Ways = []

def F(m,n)
  return 1 if n < 1
  return $Ways[n] unless $Ways[n] == nil
  count = (m..n).inject(F(m,n-1)){|sum, k| sum+F(m,n-(k+1))}
  $Ways[n] = count
  return count
end
                                                                
m = 50
n = 1
max = 10**6
while (F(m,n)<max)
  n += 1
end

puts n