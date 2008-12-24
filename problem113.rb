# Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.
# 
# Similarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.
# 
# We shall call a positive integer that is neither increasing nor decreasing a "bouncy" number; for example, 155349.
# 
# As n increases, the proportion of bouncy numbers below n increases such that there are only 12951 numbers below one-million that are not bouncy and only 277032 non-bouncy numbers below 10^(10).
# 
# How many numbers below a googol (10^(100)) are not bouncy?

#We can consider each increasing number as a sequence of length 100 of increasing digits, beginning wth 0, e.g. 00000...0023 is 23
#A decreasing number is a sequence of 11 digits, the last being -, e.g. ---------7620 stands for 7620 (so - is greater than 9)
#This sums up to the general problem - how many solutions does the equation x_1+...+x_n=k has, which is a well-known problem in combinatorics
#and has a simple solution - (n+k-1 \choose k).

#we need to fix a few bugs:
#1) 000...000 is not a valid number, and nor is ---...--- (a total of 2 numbers)
#2) every number of the form x...x with x repeating is counted twice - both as 000xxx... and ---xxx... (9 numbers for each digit)
#3) every number of the form ---000... is illegal (one number for each digit)
require 'common'
number_of_digits = 100
puts choice_with_repetitions(10,number_of_digits)+choice_with_repetitions(11,number_of_digits) - 2 - (number_of_digits*9) - (number_of_digits)