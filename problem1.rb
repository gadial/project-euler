#Find the sum of all the multiples of 3 or 5 below 1000. 
require 'common'
puts (1...1000).reject{|x| x % 3 != 0 and x % 5 != 0}.sum
puts (1...1000).reject{|x| x % 3 != 0}.sum
puts (1...1000).reject{|x| x % 5 != 0}.sum
puts (1...1000).reject{|x| x % 15 != 0}.sum
