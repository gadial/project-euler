# The following iterative sequence is defined for the set of positive integers:
# 
# n n/2 (n is even)
# n 3n + 1 (n is odd)
# 
# Using the rule above and starting with 13, we generate the following sequence:
# 13 40 20 10 5 16 8 4 2 1
# 
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.

#Standard dynamic programming

$Values = {}
def collatz(n)
  return $Values[n] unless $Values[n] == nil
  if n == 1
      result = 1
  else
      case n % 2
          when 0 then result = collatz(n / 2) + 1 
          when 1 then result = collatz(3*n + 1) + 1
      end    
  end
  $Values[n] = result
  return result
end
puts ((1...10**6).collect{|x| puts x; collatz(x)}.max_index)+1
