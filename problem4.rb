# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 * 99.
# 
# Find the largest palindrome made from the product of two 3-digit numbers.

class Integer
  def palindrome?
          num_chars=self.to_s.split("")
          num_chars.each_index{|i| return false if num_chars[i] != num_chars[-(i+1)]}
          return true
  end
end

def all_3_digit
	(100..999).to_a
end

def all_3_digit_products
	all_3_digit.collect{|x| all_3_digit.collect{|y| x*y}}.flatten.uniq
end

puts all_3_digit_products.reject{|x| not x.palindrome?}.max