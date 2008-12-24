# Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can separated into piles in exactly seven different ways, so p(5)=7.
# OOOOO
# OOOO   O
# OOO   OO
# OOO   O   O
# OO   OO   O
# OO   O   O   O
# O   O   O   O   O
# 
# Find the least value of n for which p(n) is divisible by one million.

# $Sums=[]
# 101.times {|i| $Sums[i]=[nil]*101}

# class Integer
# 	def ways_to_make_sum(max = self - 1)
# 		def inner(n,max)
# 			return 1 if n == 0 and max == 0 or max == n
# 			return 0 if n !=0 and max == 0 or max > n
# 			(1..n / max).inject(0) do |sum, i|
# # 				puts "n=#{n}, sum=#{sum}, i=#{i}"
# 				sum + (0...max).inject(0){|sum2, j| sum2+(n-i*max).ways_to_make_sum(j)}
# 			end
# 		end
# 		return $Sums[self][max] unless $Sums[self][max] == nil
# 		$Sums[self][max] = inner(self, max)
# #  		puts "$Sums[#{self}][#{max}]=#{$Sums[self][max]}"
# 		return $Sums[self][max]
# 	end
# end
# 
# $Sums[0]=[1]
# n = 1
# while true
# 	$Sums[n]=[nil]*(n+1)
# 	temp = (1..n).inject(0){|sum, i| sum+n.ways_to_make_sum(i)}
# 	puts "#{n}: #{temp}"
# 	break if temp % 10**6 == 0
# 	n += 1
# end
# puts n

$P = [1]
def compute_p(n)
	return 0 if n < 0
	return $P[n] unless $P[n] == nil
	result = (1..n).inject(0){|sum,k| sum+((-1)**(k+1 % 2))*(compute_p(n-(k*(3*k-1) / 2))+compute_p(n-(k*(3*k+1)) / 2))}
	$P[n] = result % 10**6
	return $P[n]
end

n=1
while true
	temp = compute_p(n)
	puts "#{n}: #{temp}"
	break if temp % 10**6 == 0
	n += 1
end