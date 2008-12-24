# A positive integer n is called squarefree, if no square of a prime divides n, thus 1, 2, 3, 5, 6, 7, 10, 11 are squarefree, but not 4, 8, 9, 12.
# 
# How many squarefree numbers are there below 2^50?
require 'common'
class Prob193
	def initialize
 		@n = 2**50
# 		@n = 1000
		@squares = $Primes.reject{|p| p**2>@n}.collect{|p| p**2}
		@square_num = @squares.length
		
	end
	def legal_vectors(partial_vector=[])
		puts "computing legal vector for partial #{partial_vector.inspect}"
		return [] if partial_vector.prod > @n
		result = []
		result << partial_vector unless partial_vector.empty?
		min_size = partial_vector.last || 0
		@squares.each {|x| result+=legal_vectors(partial_vector+[x]) if x>min_size}
		return result
	end
	def run
		vectors=legal_vectors
		File.open("vectors.txt","w"){|file| file.write(vectors.inspect)}
		result = vectors.inject(@n){|sum, vec| puts vec.inspect; sum+((-1)**vec.length)*(@n / vec.prod)}
		puts result
	end	
end


Prob193.new.run

# puts (1..n).reject{|x| not squares.find_all{|p| x % p ==0}.empty?}.length
# puts (n*squares.reject{|x| x>n}.inject(1.to_f){|prod, p| prod*(1-1.to_f / p)}).round
