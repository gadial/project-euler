# The rules for writing Roman numerals allow for many ways of writing each number (see FAQ: Roman Numerals). However, there is always a "best" way of writing a particular number.
#
# For example, the following represent all of the legitimate ways of writing the number sixteen:
#
# IIIIIIIIIIIIIIII
# VIIIIIIIIIII
# VVIIIIII
# XIIIIII
# VVVI
# XVI
#
# The last example being considered the most efficient, as it uses the least number of numerals.
#
# The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid, but not necessarily minimal, Roman numerals; that is, they are arranged in descending units and obey the subtractive pair rule (see FAQ for the definitive rules for this problem).
#
# Find the number of characters saved by writing each of these in their minimal form.
#
# Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.

$RomanValues = {
    1 	=> 	"I",
    4	=>	"IV",
    5 	=> 	"V",
    9	=>	"IX",
    10 	=> 	"X",
    40	=>	"XL",
    50 	=>	"L",
    90	=>	"XC",
    100 =>	"C",
    400 =>	"CD",
    500 =>	"D",
    900	=>	"CM",
    1000 =>	"M"
    }

$StandardValues = {
    "I"	=>	1,
    "V"	=>	5,
    "X"	=>	10,
    "L"	=>	50,
    "C"	=>	100,
    "D"	=>	500,
    "M"	=>	1000
    }

$Subtractable=["I", "X", "C"]
class Integer
    def to_roman
	roman_values = $RomanValues.to_a.sort{|a,b| b.first <=> a.first}
	current_value = self
	roman_string = ""
	while current_value > 0
	    if roman_values.first.first > current_value
		roman_values.shift
	    else
		current_value -= roman_values.first.first
		roman_string += roman_values.first.last
	    end
	end
	return roman_string
    end
    def Integer.from_roman(roman_string)
	current_value = 0
	roman_numerals = roman_string.split("")
	while not roman_numerals.empty?
	    current_numeral = roman_numerals.shift
	    numeral_value = $StandardValues[current_numeral]
	    numeral_value *= -1 if $Subtractable.include?(current_numeral) and not roman_numerals.empty? and $StandardValues[roman_numerals.first] > numeral_value
	    current_value += numeral_value
	end
	return current_value
    end
end

roman = File.open("roman.txt", "r"){|file| file.read.split("\r\n")}
puts roman.inject(0){|sum, r| sum + (r.length - (Integer.from_roman(r)).to_roman.length)}