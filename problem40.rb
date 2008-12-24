# An irrational decimal fraction is created by concatenating the positive integers:
# 
# 0.123456789101112131415161718192021...
# 
# It can be seen that the 12th digit of the fractional part is 1.
# 
# If dn represents the nth digit of the fractional part, find the value of the following expression.
# 
# d1 d10 d100 d1000 d10000 d100000 d1000000
require 'common'
def digit_at(n)
	digits=0
	sum=0

	while sum<n
		digits += 1
		sum += 9*(10**(digits-1))*digits
	end

	old_sum=sum - 9*(10**(digits-1))*digits
	relative_location = n-(old_sum+1)
	number = relative_location / digits
	offset = relative_location % digits
	
	(10**(digits-1)+number).digits[offset]
end

puts (0..6).inject(1){|prod, i| prod * digit_at(10**i)}