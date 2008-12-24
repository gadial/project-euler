# The series, 11 + 22 + 33 + ... + 1010 = 10405071317.
# 
# Find the last ten digits of the series, 11 + 22 + 33 + ... + 10001000.
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

n = 10**10

puts (1..1000).inject(0){|sum, x| (sum + fast_modular_exponent(x,x,n)) % n}