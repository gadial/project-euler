# The prime 41, can be written as the sum of six consecutive primes:
# 41 = 2 + 3 + 5 + 7 + 11 + 13
# 
# This is the longest sum of consecutive primes that adds to a prime below one-hundred.
# 
# The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
# 
# Which prime, below one-million, can be written as the sum of the most consecutive primes?

require 'miller-rabin'
require 'common'
# def longest_sequence(num, numbers)
# 	results = []
# 	numbers.each_index do |i|
# 		sum = 0
# 		i.upto(numbers.size) do |j|
# 			sum += numbers[j]
# 			results << (j-i+1) if sum == num
# 			break if sum >= num
# 		end
# 		break if numbers[i] > num
# 	end
# 	return results.max
# end

def longest_sequence(num, numbers)
	puts "calculating for #{num}; #{100*num / 999983}% complete"
	results = [0]
	left,right = 0,0
	sum = numbers[0]
	while numbers[left] < num
# 		puts "sum=#{sum}"
# 		puts "real sum=#{numbers[left..right].sum}"
		case sum <=> num
			when -1: right += 1; sum += numbers[right]
			when 0: results << (right - left + 1) ; sum-= numbers[left]; left+=1
			when 1: sum-= numbers[left]; left+=1
		end
				
	end
	return results.max
end
# primes = (1..10**6).find_all{|x| x.prime?}
# File.open("primes.txt","w"){|file| file.write(primes.inspect)}
primes = File.open("primes.txt","r"){|file| file.read}.split(",").collect{|x| x.to_i}

# primes = primes.reject{|x| x>1000}


puts primes.collect{|x| [x,longest_sequence(x,primes)]}.max{|a,b| a[1] <=> b[1]}.inspect