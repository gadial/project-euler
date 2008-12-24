# It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.
# 
# 9 = 7 + 212
# 15 = 7 + 222
# 21 = 3 + 232
# 25 = 7 + 232
# 27 = 19 + 222
# 33 = 31 + 212
# 
# It turns out that the conjecture was false.
# 
# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
require 'miller-rabin'

class Integer
	def ok?
		return true if self.prime?
		counter = 1
		while self - 2*(counter**2) > 0
			return true if (self - 2*(counter**2)).prime?
			counter += 1
		end
		return false
	end
end

current = 3
while current.ok?
	current += 2
end

puts current