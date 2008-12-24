# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# 
# Find the sum of all the primes below two million.
class Array
	def sum
		self.inject(0){|sum, x| sum+x}
	end
end

def fast_modular_exponent(a,k,n)
	#computes a^n
	x=1
	y=a
	while k>0
		x = (x * ((k % 2 == 1)?(y):(1))) % n
		y = (y**2) % n
		k /= 2
	end
	return x
end

def decompose(n)
	counter = 0
	while n % 2 ==0
		counter += 1
		n /= 2
	end
	return [counter, n]
end

def basic_miller_rabin_check(n,k,d)
	a=rand(self-2)+2
	t = fast_modular_exponent(a,d,n)
	return true if t == 1

	k.times do
		temp = t**2 % n
		return false if temp == 1 and (t != 1 and t != n-1)
		return true if temp == 1
		t=temp
	end
	return true if t == 1
	return false
end

class Integer
	def prime?
		return false if self == 1 or self == 0
		return true if self == 2
		#miller-rabin test
		k,d = decompose(self - 1)
		4.times {return false if basic_miller_rabin_check(self,k,d) == false}
		return true
	end
end

puts (2..2*10**6).find_all{|x| x.prime?}.sum
