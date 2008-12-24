# The palindromic number 595 is interesting because it can be written as the sum of consecutive squares: 6^(2) + 7^(2) + 8^(2) + 9^(2) + 10^(2) + 11^(2) + 12^(2).
# 
# There are exactly eleven palindromes below one-thousand that can be written as consecutive square sums, and the sum of these palindromes is 4164. Note that 1 = 0^(2) + 1^(2) has not been included as this problem is concerned with the squares of positive integers.
# 
# Find the sum of all the numbers less than 10^(8) that are both palindromic and can be written as the sum of consecutive squares.
require 'common'

class Integer
	def reverse
		self.to_s.reverse.to_i
	end
	def palindrome?(base=10)
        	num_chars=self.to_s(base).split("")
          	num_chars.each_index{|i| return false if num_chars[i] != num_chars[-(i+1)]}
          	return true
  	end
end

max = 10**8
squares = (1..max.sqrt.to_i).collect{|x| x**2}
palindromes = []
squares.length.times do |a|
    puts 100*a.to_f / squares.length
    (a+1).upto(squares.length) do |b|
	sum = squares[a..b].sum
	palindromes << sum if sum.palindrome?
	break if sum > max
    end
end
palindromes.uniq!.sort!
puts palindromes.inspect
puts palindromes.sum