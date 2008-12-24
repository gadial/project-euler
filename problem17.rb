# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# 
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
# 
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
require 'common'

class Integer
	def to_word
          number_names = {
                  1 => "one",
                  2 => "two",
                  3 => "three",
                  4 => "four",
                  5 => "five",
                  6 => "six",
                  7 => "seven",
                  8 => "eight",
                  9 => "nine",
                  10 => "ten",
                  11 => "eleven",
                  12 => "twelve",
                  13 => "thirteen",
                  14 => "fourteen",
                  15 => "fifteen",
                  16 => "sixteen",
                  17 => "seventeen",
                  18 => "eighteen",
                  19 => "nineteen",
                  20 => "twenty",
                  30 => "thirty",
                  40 => "forty",
                  50 => "fifty",
                  60 => "sixty",
                  70 => "seventy",
                  80 => "eighty",
                  90 => "ninety",
                  100 => "hundred",
                  1000 => "one thousand",	
          }
		raise "don't know how" if self>1000
		digits = self.digits.expand(4,true)
		return number_names[self] if (self <= 20) or (self == 1000)
		return "#{number_names[digits[2]*10]}-#{number_names[digits[3]]}" if (self>20 and self<100 and self % 10 != 0)
		return "#{number_names[digits[2]*10]}" if (self>20 and self<100 and self % 10 == 0)
		return "#{number_names[digits[1]]} #{number_names[100]} and #{(digits[2]*10+digits[3]).to_word}" if (self >= 100 and self < 1000 and self % 100 != 0)
		return "#{number_names[digits[1]]} #{number_names[100]}" if (self >= 100 and self < 1000 and self % 100 == 0)
	end
end

puts (1..1000).collect{|x| x.to_word.clean.length}.sum
