# We can easily verify that none of the entries in the first seven rows of Pascal's triangle are divisible by 7:
#   	  	  	  	  	  	 1
#   	  	  	  	  	 1 	  	 1
#   	  	  	  	 1 	  	 2 	  	 1
#   	  	  	 1 	  	 3 	  	 3 	  	 1
#   	  	 1 	  	 4 	  	 6 	  	 4 	  	 1
#   	 1 	  	 5 	  	10 	  	10 	  	 5 	  	 1
# 1 	  	 6 	  	15 	  	20 	  	15 	  	 6 	  	 1
# 
# However, if we check the first one hundred rows, we will find that only 2361 of the 5050 entries are not divisible by 7.
# 
# Find the number of entries which are not divisible by 7 in the first one billion (10^(9)) rows of Pascal's triangle.

#the main observation needed here is that for row n (starting with 0), if we write n in base p, i.e.
#n = \sum{i=0}^k a_ip^i
#then we have that the number of entries in that row is exactly (a_0+1)(a_1+1)...(a_k+1)

require 'common'

def sum_upto(digits,p)
    return 1 if digits.empty?
    k = digits.length - 1
    n = digits.first
    (n*(n+1) / 2)*(p*(p+1) / 2)**k + (n+1)*sum_upto(digits[1..-1],p)	
end

max = 10**9
p = 7
puts sum_upto((max-1).digits(p),p)