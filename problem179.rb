#Find the number of integers 1 < n < 10^(7), for which n and n + 1 have the same number of positive divisors. For example, 14 has the positive divisors 1, 2, 7, 14 while 15 has 1, 3, 5, 15.

max = 10**7
number_of_divisors = [1] * max
(2...max).each do |n|
  puts n
  k = n
  while k < max
    number_of_divisors[k] += 1
    k += n
  end
end

count = 0 #(don't want to count the 0 at the beginning of number_of_divisors)
number_of_divisors.each_index{|i| count += 1 if i>1 and number_of_divisors[i] == number_of_divisors[i-1]}
puts count
#puts number_of_divisors.inspect