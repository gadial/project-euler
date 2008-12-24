# It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
# 
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

require 'common'
multiples = 6

current = 0

is_ok = false
while not is_ok
	is_ok = true
	current += 1
	digits = current.digits.sort
	(1..multiples).each do |i| 
		if (i*current).digits.sort != digits
			is_ok = false
			break
		end
	end
end

puts current

