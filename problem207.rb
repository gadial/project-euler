# For some positive integers k, there exists an integer partition of the form   4^(t) = 2^(t) + k,
# where 4^(t), 2^(t), and k are all positive integers and t is a real number.
# 
# The first two such partitions are 4^(1) = 2^(1) + 2 and 4^(1.5849625...) = 2^(1.5849625...) + 6.
# 
# Partitions where t is also an integer are called perfect.
# For any m ≥ 1 let P(m) be the proportion of such partitions that are perfect with k ≤ m.
# Thus P(6) = 1/2.
# 
# In the following table are listed some values of P(m)
# 
#    P(5) = 1/1
#    P(10) = 1/2
#    P(15) = 2/3
#    P(20) = 1/2
#    P(25) = 1/2
#    P(30) = 2/5
#    ...
#    P(180) = 1/4
#    P(185) = 3/13
# 
# Find the smallest m for which P(m) < 1/12345

#the total number of values of t is (n-1) where n is the largest integer satisfying x(x-1) <= m
#The proportion depends on the number of values in (2..n) that are powers of 2
require 'common'
def find_min_for_goal(goal)
    current_power = 0
    current = 1
    ratio = 1
    while ratio >= goal
	current_power += 1
	current *= 2
	ratio = current_power.to_f / (current-1)
    end
    current_power -= 1
    while ratio < goal
	current -=1
	ratio = current_power.to_f / (current-1)
#  	puts "current=#{current}, ratio = #{ratio}, goal = #{goal}"
    end
    return current + 1
end

goal = 1.to_f / 12345
x = find_min_for_goal(goal)
puts x*(x-1)