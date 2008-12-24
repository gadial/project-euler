# The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
# 
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
# 
# How many circular primes are there below one million?
require 'common'
require 'miller-rabin'
class Integer
	def circulars
		result = []
		temp = self
		len = self.digits.length
		len.times do
			result << temp
			temp = (temp / 10) + (temp % 10)*10**(len-1)
		end
		return result.uniq
	end
end

# to_check = (2...10**6).to_a
# result = []
# while not to_check.empty?
# 	num = to_check.first
# 	all_nums=num.circulars
# 	result += all_nums if all_nums.reject{|x| x.prime?}.empty?
# 	to_check -= all_nums
# end

result = [2]
(3...10**6).each do |num|
	next if not (num.digits & [0,2,4,6,8]).empty?
	all_nums=num.circulars
	result += all_nums if all_nums.reject{|x| x.prime?}.empty?
end

puts "got here"
puts result.uniq.length