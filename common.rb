# $Primes = File.open("primes.txt","r"){|file| file.read.split(",").collect{|p| p.to_i}}
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
		while temp > 1
			p=$Primes[i]
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
	def sqrt(epsilon=0.000001)
		#basic newton-raphson
		old = 0.0
		new = self.to_f
		while (new-old).abs > epsilon
			old, new = new, (new / 2) + (self.to_f / (2*new))
		end
		return new
	end
	def integer_sqrt
		x = self
		y = x - 1
		while y < x
			x = y
			y = (x + (self / x)) / 2
		end
		return nil unless y**2 == self
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
	def sqrt_modulo_p(p, assured_to_be_qr = false)
		#p is an odd prime
		raise "#{self} is not a quadratic residue modulo #{p}" unless assured_to_be_qr or fast_modular_exponent(self, (p-1) / 2,p) == 1
		return fast_modular_exponent(self, (p+1) / 4, p) if (p % 4) == 3 #the simple case
		if (p % 8) == 5 #another simple case
			return fast_modular_exponent(self, (p+3) / 8, p) if fast_modular_exponent(self, (p-1) / 4, p) == 1
			return 2*self*fast_modular_exponent(4*self, (p-5) / 8, p)
		end
# 		# p = 1 mod 8; we use Tonelli and Shanks
 		non_qr = nil
 		20.times {t = rand(p-2)+2; if not t.qr_modulo?(p) then non_qr = t; break end}
		raise "could not find a non quadratic residue modulo #{p}" if non_qr == nil

		#now writing p-1 as p-1=2^alpha*s where s is odd
		alpha = 0
		temp = p-1
		while temp % 2 == 0
			alpha += 1
			temp /= 2
		end
		s = temp

		# r is "almost" the sqrt of self
		r = fast_modular_exponent(self, (s+1 / 2), p)
		r_a_ratio = (r**2 * self.inverse_modulo(p)) % p
		j = 0 #j will be the power of b in sqrt(a) = r*b^j
		(alpha-1).times do |k|
		end
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

# prime = 17
# num = 13
# s=num.sqrt_modulo_p(prime)
# puts "s=#{s}, s*s=#{s*s % prime}, num=#{num}"

# puts chinese_remainder_theorem([1,2,3,4],[5,6,7,11])