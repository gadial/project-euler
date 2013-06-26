# A positive integer with k (decimal) digits is called balanced if its first k/2 digits sum to the same value as its last k/2 digits, where x, pronounced ceiling of x, is the smallest integer  x, thus π = 4 and 5 = 5.
# 
# So, for example, all palindromes are balanced, as is 13722.
# 
# Let T(n) be the sum of all balanced numbers less than 10^n. 
# Thus: T(1) = 45, T(2) = 540 and T(5) = 334795890.
# 
# Find T(47) mod 3^15

#given a number A=a1a2...akbc1c2...ck with sum-difference t and two new digits x,y we can form the number
# xa1a2...akbc1c2...cky with sum-difference t+(x-y), whose value is 10A+x(10^{k+1})+y

#but what about numbers that start with 0? We don't allow them, but only in the last iteration of adding x and y
MODULUS = 3**15

def S(t)
  num_counts = []
  num_counts[0] = {0 => [1,0]}
  num_counts[1] = {0 => [10,45]}
  n = t % 2
  while n < t
    counts = num_counts[n]
    n += 2
    num_counts[n] = Hash.new{|hash, key| hash[key]=[0,0]}
    x_range = (0..9).to_a
    y_range = (0..9).to_a
    x_range.shift if n == t
    for x in x_range do
      for y in y_range do
	for count in counts do
	  delta = count.first + x - y
	  num_counts[n][delta][0] += count.last[0]
	  num_counts[n][delta][1] += 10*count.last[1] + (x*(10**(n-1)) + y)*count.last[0]
	  num_counts[n][delta][1] = num_counts[n][delta][1] % MODULUS
	end
      end
    end
  end
  num_counts[t][0].last
end
N = 47
puts (1..N).inject(0){|sum, t| puts "%2.0f%" % (t*100.0/N); (sum + S(t)) % MODULUS}.inspect
