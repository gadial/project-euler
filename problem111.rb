#Considering 4-digit primes containing repeated digits it is clear that they cannot all be the same: 1111 is divisible by 11, 2222 is divisible by 22, and so on. But there are nine 4-digit primes containing three ones:
#
#1117, 1151, 1171, 1181, 1511, 1811, 2111, 4111, 8111
#
#We shall say that M(n, d) represents the maximum number of repeated digits for an n-digit prime where d is the repeated digit, N(n, d) represents the number of such primes, and S(n, d) represents the sum of these primes.
#
#So M(4, 1) = 3 is the maximum number of repeated digits for a 4-digit prime where one is the repeated digit, there are N(4, 1) = 9 such primes, and the sum of these primes is S(4, 1) = 22275. It turns out that for d = 0, it is only possible to have M(4, 0) = 2 repeated digits, but there are N(4, 0) = 13 such cases.
#
#In the same way we obtain the following results for 4-digit primes.
#Digit, d 	M(4, d) 	N(4, d) 	S(4, d)
#0 	2 	13 	67061
#1 	3 	9 	22275
#2 	3 	1 	2221
#3 	3 	12 	46214
#4 	3 	2 	8888
#5 	3 	1 	5557
#6 	3 	1 	6661
#7 	3 	9 	57863
#8 	3 	1 	8887
#9 	3 	7 	48073
#
#For d = 0 to 9, the sum of all S(4, d) is 273700.
#
#Find the sum of all S(10, d).
require 'miller-rabin'
require 'common'
def generate_numbers_with_repeated_digit(total_digit_num, repeated_digit_num, repeated_digit)
  return [""] if total_digit_num < repeated_digit_num or total_digit_num <= 0
  return [repeated_digit*repeated_digit_num] if total_digit_num == repeated_digit_num #assuming repeated_digit is string
  digits = (0..9).collect{|d| d.to_s}.reject{|d| d==repeated_digit}
  result = []
  digits.each do |d|
      result += generate_numbers_with_repeated_digit(total_digit_num -1, repeated_digit_num, repeated_digit).collect{|num| d + num}
  end
  result += generate_numbers_with_repeated_digit(total_digit_num -1, repeated_digit_num - 1, repeated_digit).collect{|num| repeated_digit + num}
  return result
end

def find_primes(n,d)
  repeated_digit_num = n
  primes_found = []
  while primes_found.empty?
    repeated_digit_num -= 1
    candidates = generate_numbers_with_repeated_digit(n, repeated_digit_num, d.to_s)
#    puts candidates.inspect
    primes_found = candidates.reject{|num| num[0..0]=="0"}.collect{|num| num.to_i}.find_all{|num| num.prime?}
  end
  return primes_found
end
def s(n,d)
  find_primes(n,d).sum
end
#puts generate_numbers_with_repeated_digit(1, 0, 1.to_s).inspect
#puts find_primes(4,1).inspect

n = 10
puts((0..9).collect{|d| s(n,d)}.sum)

