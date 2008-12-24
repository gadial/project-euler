# It is possible to write five as a sum in exactly six different ways:
# 
# 4 + 1
# 3 + 2
# 3 + 1 + 1
# 2 + 2 + 1
# 2 + 1 + 1 + 1
# 1 + 1 + 1 + 1 + 1
# 
# How many different ways can one hundred be written as a sum of at least two positive integers?

$Sums=[]
101.times {|i| $Sums[i]=[nil]*101}

class Integer
	def ways_to_make_sum(max = self - 1)
		def inner(n,max)
			return 1 if n == 0 and max == 0 or max == n
			return 0 if n !=0 and max == 0 or max > n
			(1..n / max).inject(0) do |sum, i|
# 				puts "n=#{n}, sum=#{sum}, i=#{i}"
				sum + (0...max).inject(0){|sum2, j| sum2+(n-i*max).ways_to_make_sum(j)}
			end
		end
		return $Sums[self][max] unless $Sums[self][max] == nil
		$Sums[self][max] = inner(self, max)
# 		puts "$Sums[#{self}][#{max}]=#{$Sums[self][max]}"
		return $Sums[self][max]
	end
end

n=100
puts (1...n).inject(0){|sum, i| sum+n.ways_to_make_sum(i)}