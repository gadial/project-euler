# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# 
# What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?

def gcd(x,y)
	return gcd(y,x) if x<y
	return y if x % y == 0
	return gcd(y, x % y)
end

def lcm(x,y)
	return x*y / gcd(x,y)
end

puts (2..20).inject(1){|x,y| lcm(x,y)}