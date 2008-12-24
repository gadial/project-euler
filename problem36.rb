# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
# 
# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
# 
# (Please note that the palindromic number, in either base, may not include leading zeros.)
require 'common'
class Integer
  def palindrome?(base=10)
          num_chars=self.to_s(base).split("")
          num_chars.each_index{|i| return false if num_chars[i] != num_chars[-(i+1)]}
          return true
  end
end

puts (1...10**6).find_all{|x| x.palindrome?(2) and x.palindrome?(10)}.sum