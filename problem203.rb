#The binomial coefficients ^(n)C_(k) can be arranged in triangular form, Pascal's triangle, like this:
#  1 
#  1   1 
#  1   2   1 
#  1   3   3   1 
#  1   4   6   4   1 
#  1   5   10    10    5   1 
#  1   6   15    20    15    6   1 
#1   7   21    35    35    21    7   1
#.........
#
#It can be seen that the first eight rows of Pascal's triangle contain twelve distinct numbers: 1, 2, 3, 4, 5, 6, 7, 10, 15, 20, 21 and 35.
#
#A positive integer n is called squarefree if no square of a prime divides n. Of the twelve distinct numbers in the first eight rows of Pascal's triangle, all except 4 and 20 are squarefree. The sum of the distinct squarefree numbers in the first eight rows is 105.
#
#Find the sum of the distinct squarefree numbers in the first 51 rows of Pascal's triangle.
require 'common'
def find_squarefrees(n)
    factorizations = (0..n).collect{|x| x.prime_divisors}
    current_factorization = [0]*(n+1)
    (1..n / 2).find_all do |k|
        factorizations[n-k+1].each{|p| current_factorization[p] += 1}
        factorizations[k].each{|p| current_factorization[p] -= 1}
#        puts "for #{n} choose #{k}, factorization is #{current_factorization.inspect}"
        not current_factorization.find{|x| x >= 2}
    end  
end
max = 51
results = [1]
max.times do |n|
    puts n
    results << find_squarefrees(n).collect{|k| choose(n,k)}
end

puts results.flatten.uniq.sum
#t = 10**2
#puts t.prime_divisors.length