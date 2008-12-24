# In the hexadecimal number system numbers are represented using 16 different digits:
# 
# 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F
# 
# The hexadecimal number AF when written in the decimal number system equals 10x16+15=175.
# 
# In the 3-digit hexadecimal numbers 10A, 1A0, A10, and A01 the digits 0,1 and A are all present.
# Like numbers written in base ten we write hexadecimal numbers without leading zeroes.
# 
# How many hexadecimal numbers containing at most sixteen hexadecimal digits exist with all of the digits 0,1, and A present at least once?
# Give your answer as a hexadecimal number.
# 
# (A,B,C,D,E and F in upper case, without any leading or trailing code that marks the number as hexadecimal and without leading zeroes , e.g. 1A3F and not: 1a3f and not 0x1a3f and not $1A3F and not #1A3F and not 0000001A3F)
$NumberOfDigits = 16

def hexadecimal_numbers_without_forbiddens_with_n_digits(n, forbiddens)
	return ($NumberOfDigits - forbiddens.length)**n if forbiddens.include?("0")
	return (($NumberOfDigits - 1) - forbiddens.length)*($NumberOfDigits - forbiddens.length)**(n-1)
end

def hexadecimal_numbers_with_forbiddens_with_n_digits(n)
 	#inclusion-exclusion
  	alias hf hexadecimal_numbers_without_forbiddens_with_n_digits
	hf(n,[]) - (hf(n,["A"]) + hf(n,["0"]) + hf(n,["1"])) + (hf(n,["A","0"]) + hf(n,["A","1"]) + hf(n,["0","1"])) - hf(n,["A","0","1"])
end

puts (1..16).inject(0){|sum,x| sum + hexadecimal_numbers_with_forbiddens_with_n_digits(x)}.to_s(16).upcase!

