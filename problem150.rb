# 
# 
# In a triangular array of positive and negative integers, we wish to find a sub-triangle such that the sum of the numbers it contains is the smallest possible.
# 
# In the example below, it can be easily verified that the marked triangle satisfies this condition having a sum of −42.
# 
# We wish to make such a triangular array with one thousand rows, so we generate 500500 pseudo-random numbers sk in the range ±219, using a type of random number generator (known as a Linear Congruential Generator) as follows:
# 
# t := 0
# for k = 1 up to k = 500500:
#     t := (615949*t + 797807) modulo 220
#     sk := t−219
# 
# Thus: s1 = 273519, s2 = −153582, s3 = 450905 etc
# 
# Our triangular array is then formed using the pseudo-random numbers thus:
# s1
# s2  s3
# s4  s5  s6 
# s7  s8  s9  s10
# ...
# 
# Sub-triangles can start at any element of the array and extend down as far as we like (taking-in the two elements directly below it from the next row, the three elements directly below from the row after that, and so on).
# The "sum of a sub-triangle" is defined as the sum of all the elements it contains.
# Find the smallest possible sub-triangle sum.
def index(row, offset)
  row*(row-1)/2 + offset
end

ROWS = 1000
NUM = ROWS*(ROWS+1) / 2

t = 0
s = []
NUM.times do |k|
   t = (615949*t + 797807) % 2**20
   s[k] = t - 2**19
end

minsum = 0
row_values = []
ROWS.downto(1) do |current_row|
  row_values.unshift([])
  row_values.pop if row_values.length > 3
  current_row.times do |offset|
    vals = [s[index(current_row,offset)]]
    if ROWS-current_row > 0
      vals << s[index(current_row,offset)] + s[index(current_row+1,offset)] + s[index(current_row+1,offset+1)]
    end
    for k in (2..ROWS-current_row) do
      vals << s[index(current_row,offset)] + row_values[1][offset][k-1] + row_values[1][offset+1][k-1] - row_values[2][offset+1][k-2]
    end
    minsum = ([minsum] + vals).min
    row_values[0] << vals
  end
end

puts minsum