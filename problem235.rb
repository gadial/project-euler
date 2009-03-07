# Given is the arithmetic-geometric sequence u(k) = (900-3k)r^(k-1).
# Let s(n) = Σ_(k=1...n)u(k).
# 
# Find the value of r for which s(5000) = -600,000,000,000.
# 
# Give your answer rounded to 12 places behind the decimal point.
def geometric_sum(a1,r,n)
    #a1+a1r+...+a1r^{n-1}
    a1*(r**n-1).to_f / (r-1)
end
def arithmetic_geometric_sum(a1,d,r,n)
	geometric_sum(a1,r,n) + d*(n*r**n - geometric_sum(1,r,n)).to_f / (r-1)
end

a1 = 900
d = -3
n = 5000
goal = -600000000000

min = 1.0
max = 1.1

epsilon = 10**(-12)

old_r = 0
r = (max + min) / 2

while (r-old_r).abs > epsilon
    if arithmetic_geometric_sum(a1,d,r,n) > goal
	min = r
    else
	max = r
    end
    old_r = r
    r = (max + min) / 2
end

printf ("%.12f\n",r)
