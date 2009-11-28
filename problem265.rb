# 2^(N) binary digits can be placed in a circle so that all the N-digit clockwise subsequences are distinct.
# 
# For N=3, two such circular arrangements are possible, ignoring rotations:
# 
# For the first arrangement, the 3-digit subsequences, in clockwise order, are:
# 000, 001, 010, 101, 011, 111, 110 and 100.
# 
# Each circular arrangement can be encoded as a number by concatenating the binary digits starting with the subsequence of all zeros as the most significant bits and proceeding clockwise. The two arrangements for N=3 are thus represented as 23 and 29:
# 00010111 _(2) = 23
# 00011101 _(2) = 29
# 
# Calling S(N) the sum of the unique numeric representations, we can see that S(3) = 23 + 29 = 52.
# 
# Find S(5).
require 'common'

def recurse(current_node, visited_nodes,n)
  return [visited_nodes] if 2**n == visited_nodes.length
  result = []
  for new_char in ["0","1"] do
    temp_node = current_node[1..-1] + new_char
    result += recurse(temp_node, visited_nodes + [temp_node], n) unless visited_nodes.include?(temp_node)
  end
  return result
end

def find_cycles(n)
    initial_node = "0"*n
    initial_path = [initial_node]
    recurse(initial_node,initial_path,n)
end

def path_to_number(path)
  path.inject(""){|sum, x| sum + x[-1..-1]}.to_i(2)
end
  
n  = 5
puts find_cycles(n).collect{|path| path_to_number(path[0..-n])}.sum
