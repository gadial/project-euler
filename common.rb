# $Primes = File.open("primes.txt","r"){|file| file.read.split("\n").collect{|p| p.to_i}}

def sieve_primes(max)
	divided = []
	primes = []
	(2..max).each do |n|
		primes << n if divided[n] == nil
		temp = n
		while temp <= max
			temp += n
			divided[temp] = true
		end
	end
	return primes
end

def solve_equation(a,b,c)
	(-b + (b**2 - 4*a*c).sqrt) / (2*a)
end

def compute_jacobi_symbol(a,b)
#     puts "(#{a}/#{b})"
    raise "b=#{b} must be odd" unless b.odd?
    return 0 if a ==0
    return 1 if a == 1
    return 1 if b == 1
    return compute_jacobi_symbol(-a,b)*((b % 4 == 1)?(1):(-1)) if a < 0
    return compute_jacobi_symbol(a % b, b) if a > b
    temp = 1
    while a % 2 == 0
	a /= 2
	temp *= (([1,7].include?(b % 8))?(1):(-1))
    end
    return temp if a == 1
    temp *= ((a % 4 == 1 or b % 4 == 1)?(1):(-1)) # quadratic reciprocity
    return temp * compute_jacobi_symbol(b % a, a)
end

def fast_modular_exponent(a,k,n)
	#computes a^k modulo n
	x=1
	y=a
	while k>0
		x = (x * ((k % 2 == 1)?(y):(1))) % n
		y = (y**2) % n
		k /= 2
	end
	return x
end

def chinese_remainder_theorem(a_vector, m_vector, y_vector = nil)
	#finds x such that x = a_i mod m_i
	raise "a (length #{a_vector.length}) and m (length #{m_vector.length}) are not of the same length!" if a_vector.length != m_vector.length
	
	b_m = m_vector.prod
	y_vector = m_vector.collect{|m_i| t=(b_m / m_i); t*t.inverse_modulo(m_i)} if y_vector == nil
	return (0...a_vector.length).collect{|i| a_vector[i]*y_vector[i]}.sum % b_m
end
class Array
	def sum
		self.inject(0){|sum, x| sum+x}
	end
	def prod
		self.inject(1){|prod, x| prod*x}
	end
	def exists?
	  not find_all{|x| yield(x)}.empty?
	end
	def all_uniq?
	    self.uniq.length == self.length
	end
	def expand(size, front=false)
		return self.dup if self.size >= size
		return [0]*(size-self.size) + self if front
		return self + [0]*(size-self.size)
	end
	def all_indexes(value)
		result = []
			each_index{|i| result << i if value == self[i]}
		return result
	end
	def collect_with_index
		result = []
		self.length.times do |i|
			result << yield(self[i], i)
		end
		return result
	end
	def all_permutations
		return [[]] if empty?
		sort.inject([]){|sum,x| sum += (self-[x]).all_permutations.collect{|p| p.unshift(x)}}
	end
	def all_fullfill
		each {|x| return false unless yield(x)}
		true
	end
	def all_choices_with_repetitions(k)
		return collect{|x| [x]} if k == 1
		result = []
		each {|x| result += all_choices_with_repetitions(k-1).collect{|t| t+[x]}}
		return result
	end
	def all_choices_without_repetitions(k)
		return collect{|x| [x]} if k == 1
		result = []
		each {|x| result += (self - [x]).all_choices_without_repetitions(k-1).collect{|t| t+[x]}}
		return result
	end
	def forall
		each {|x| return false unless yield(x)}
		return true
	end
	def choose_by_binary_vector(vector)
	    result = []
	    vector.each_index {|i| result << self[i] if vector[i] == 1}
	    return result
	end
	def all_subsets
	    (0...(2**self.length)).collect{|n| choose_by_binary_vector(n.to_s_padded(2,self.length).split("").collect{|s| s.to_i})}
	end
	def count(&proc)
		find_all(&proc).length
	end
end

class Integer
	def find_qr
	  (0...self).collect{|a| a**2 % self}.uniq.sort
	end
	@@qr_mod_11 = 11.find_qr
	@@qr_mod_63 = 63.find_qr
	@@qr_mod_64 = 64.find_qr
	@@qr_mod_65 = 65.find_qr
	
	def digits(base=10)
		self.to_s(base).split("").collect{|x| x.to_i(base)}
	end
	def number_of_digits(base = 10)
	    self.to_s(base).length
	end
	def sum_of_digits(base=10)
		digits(base).sum
	end
	def to_s_padded(base, min_length)
	    s = self.to_s(base)
	    while s.length < min_length
		s = "0" + s
	    end
	    return s
	end
	def uniq_divisors
		([1] + proper_divisors + [self]).uniq
	end
	def proper_divisors
		#naive
		(2...self).reject{|x| self % x !=0}
	end
	def prime_divisors
		temp = self
		result = []
		i=0
		p = 2
		while temp > 1
# 			p=$Primes[i]
			p = (p..temp).find{|x| temp % x == 0}
			while temp % p == 0
				result << p
				temp /= p
			end
			i += 1
		end
		return result
	end
	def factorial
		(2..self).inject(1){|prod, x| prod*x}
	end
	def to_s_factored
		return "1" if self == 1
		p = prime_divisors
		p.uniq.collect{|x| "(#{x}^#{p.count{|t| t==x}})"}.join("*")
	end
	def sqrt(epsilon=0.000001)
		#basic newton-raphson
		old = 0.0
		new = self.to_f
		while (new-old).abs > epsilon
			old, new = new, (new / 2) + (self.to_f / (2*new))
		end
		return new
	end
	def integer_sqrt(approx = false)
		return 1 if self == 1
		x = self
		y = x - 1
		while y < x
			x = y
			y = (x + (self / x)) / 2
		end
		return nil unless y**2 == self or approx==true
		return y
# 	    #binary search
# 	    lb = 1
# 	    ub = self
# 	    while (ub - lb).abs > 1
# 	      mid = (ub+lb) / 2
# # 	      puts "(#{lb}..#{ub}), #{mid}"
# 	      sq = mid**2
# 	      return mid if sq == self
# 	      ub = mid if sq > self
# 	      lb = mid if sq < self
# 	    end
# 	    return nil
		
	end
	def sqrt_modulo_p(p, assured_to_be_qr = false, non_qr = nil)
		#p is an odd prime
		raise "#{self} is not a quadratic residue modulo #{p}" unless assured_to_be_qr or fast_modular_exponent(self, (p-1) / 2,p) == 1
		return fast_modular_exponent(self, (p+1) / 4, p) if (p % 4) == 3 #the simple case
		if (p % 8) == 5 #another simple case
			return fast_modular_exponent(self, (p+3) / 8, p) if fast_modular_exponent(self, (p-1) / 4, p) == 1
			return 2*self*fast_modular_exponent(4*self, (p-5) / 8, p)
		end
# 		# p = 1 mod 8; we use Tonelli and Shanks
		20.times {t = rand(p-2)+2; if not t.qr_modulo?(p) then non_qr = t; break end} if non_qr == nil
		raise "could not find a non quadratic residue modulo #{p}" if non_qr == nil

		#now writing p-1 as p-1=2^k*t where t is odd
		k = 0
		temp = p-1
		while temp % 2 == 0
			k += 1
			temp /= 2
		end
		
		t = temp
		puts "qnr = #{non_qr}"
		puts "k, t = #{k}, #{t}"
		z = fast_modular_exponent(non_qr, t, p)
		puts "z = #{z}"
		#finished the "pre-processing", turning to deal with self
# 		puts "p=#{p}, p-1 = 2^#{k}*#{t}"
		
		y = fast_modular_exponent(self, t, p)
		x = fast_modular_exponent(self, (t+1) / 2, p)
		puts "x, y = #{x}, #{y}"
# 		puts "self = #{self}, y = #{y}, x = #{x}"
		(0..k-1).each do |i|
		    puts "exp = #{2**(k-2-i)}"
		    b = fast_modular_exponent(y,2**(k-2-i),p)
		    puts "i, b = #{i}, #{b}"
		    case b
			when 1 #do nothing, everything ok
			when p-1 # -1
			    x = (x*z) % p
			    y = (y*z*z) % p
			else
			    raise "b = #{b}, which is very odd" unless b == -1    			    
		    end 
		    z = (z*z) % p
		    puts "x, y, z = #{x}, #{y}, #{z}"
		end
		return x % p
	end
	def gcd(y)
		return self.abs.gcd(y.abs) if self<0 or y<0
		return y.gcd(self) if self<y
		return self if y == 0
		return y if self % y == 0
		return y.gcd(self % y)
	end
	def even?
		self % 2 == 0
	end
	def odd?
		self % 2 != 0
	end
	def square?
	      return false unless @@qr_mod_64.include?(self % 64)
	      r = self % 45045
	      return false unless @@qr_mod_63.include?(r % 63)
	      return false unless @@qr_mod_65.include?(r % 65)
	      return false unless @@qr_mod_11.include?(r % 11)

 	      integer_sqrt != nil
#  	      (sqrt.to_i)**2 == self
	end
	def extended_gcd(b)
		return [self,1,0] if b == 0
		q = self / b
		r = self % b
		gcd, x, y = b.extended_gcd(r)
		return [gcd, y, x-q*y]
	end
# 	def extended_gcd(y)
# 		#finds r_x, r_y such that r_x*x+r_y*y=gcd(x,y)
# 		x = self
# 		r_x_1, r_x_2 = 1, 0
# 		r_y_1, r_y_2 = 0, 1
# 		while x % y != 0
# 			#x = qy+r, r>1
# 			q = x / y
# 			x,y = y, x % y
# 			r_x_1, r_x_2, r_y_1, r_y_2 = r_y_1, r_y_2, (r_x_1-q*r_y_1), (r_x_2-q*r_y_2)
# 		end
# 		return [y, r_y_1, r_y_2]
# 	end
	def inverse_modulo(n)
		return nil unless self.gcd(n) == 1
		(n.extended_gcd(self).last) % n
	end
	def qr_modulo?(p)
	  #p assumed to be prime
	  fast_modular_exponent(self, (p-1) / 2, p) == 1 #Euler's criterion
	end
	def upto_inf
	    n = self
	    while true
		yield(n)
		n +=1
	    end
	end
end

class Float
	def sqrt
		#basic newton-raphson
		raise "trying to sqrt the negative number #{self}" if self < 0
		old = 0.0
		new = self
		while (new-old).abs > 0.000001
			old, new = new, (new / 2) + (self.to_f / (2*new))
		end
		return new
	end
end

class String
	def clean
		self.split("").reject{|x| not x=~/[a-zA-Z]/}.join("")
	end
	def cycle(i)
		self[i..-1] + self[0...i]
	end
end

#Combinatorics section:

def choose(n,k)
	(1..k).inject(1){|prod, i| prod*(n-i+1) / (i)}
end

def choice_with_repetitions(n,k)
	choose(n+k-1,k)
end
# puts compute_jacobi_symbol(141,1033)
# puts 135.sqrt_modulo_p(833)

# (1..4*n).reject{|a| a.gcd(4*n) != 1}.find_all{|a| puts "(#{-4*n}/#{a})=#{compute_jacobi_symbol(-4*n,a)==1}"}
# puts compute_jacobi_symbol(-1,9)
# # puts compute_jacobi_symbol(3,7)
# puts 300.to_s_factored
# prime = 17
# num = 13
# s=num.sqrt_modulo_p(prime)
# puts "s=#{s}, s*s=#{s*s % prime}, num=#{num}"

# puts chinese_remainder_theorem([1,2,3,4],[5,6,7,11])