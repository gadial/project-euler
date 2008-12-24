# Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.
# 
# Similarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.
# 
# We shall call a positive integer that is neither increasing nor decreasing a "bouncy" number; for example, 155349.
# 
# Clearly there cannot be any bouncy numbers below one-hundred, but just over half of the numbers below one-thousand (525) are bouncy. In fact, the least number for which the proportion of bouncy numbers first reaches 50% is 538.
# 
# Surprisingly, bouncy numbers become more and more common and by the time we reach 21780 the proportion of bouncy numbers is equal to 90%.
# 
# Find the least number for which the proportion of bouncy numbers is exactly 99%.

require 'common'
class Integer
	def increasing?
		dig = digits
		(1...dig.length).each{|i| return false if dig[i-1] > dig[i]}
		return true
	end
	def decreasing?
		dig = digits
		(1...dig.length).each{|i| return false if dig[i-1] < dig[i]}
		return true
	end
	def bouncy?
		not increasing? and not decreasing?
	end
end

count = 0
current = 1
proportion = 100 * count.to_f / current
while  proportion < 99.0
	current += 1
	count += 1 if current.bouncy?
	proportion = 100 * count.to_f / current
	puts "current=#{current}, proportion=#{proportion}"
end