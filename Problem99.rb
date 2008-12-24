# Comparing two numbers written in index form like 211 and 37 is not difficult, as any calculator would confirm that 211 = 2048  37 = 2187.

# However, confirming that 632382518061 519432525806 would be much more difficult, as both numbers contain over three million digits.

# Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file containing one thousand lines with a base/exponent pair on each line, determine which line number has the greatest numerical value.

# NOTE: The first two lines in the file represent the numbers in the example given above.

require 'mathn'
number_pairs = File.open("base_exp.txt","r"){|file| file.read}.split("\n").collect{|line| line.split(",")}.collect{|pair| [pair[0].to_i, pair[1].to_i]}

values = number_pairs.collect{|pair| Math.log(pair[0])*pair[1]}
puts values.index(values.max)