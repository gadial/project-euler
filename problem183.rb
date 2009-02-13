# Let N be a positive integer and let N be split into k equal parts, r = N/k, so that N = r + r + ... + r.
# Let P be the product of these parts, P = r × r × ... × r = r^(k).
# 
# For example, if 11 is split into five equal parts, 11 = 2.2 + 2.2 + 2.2 + 2.2 + 2.2, then P = 2.2^(5) = 51.53632.
# 
# Let M(N) = P_(max) for a given value of N.
# 
# It turns out that the maximum for N = 11 is found by splitting eleven into four equal parts which leads to P_(max) = (11/4)^(4); that is, M(11) = 14641/256 = 57.19140625, which is a terminating decimal.
# 
# However, for N = 8 the maximum is achieved by splitting it into three equal parts, so M(8) = 512/27, which is a non-terminating decimal.
# 
# Let D(N) = N if M(N) is a non-terminating decimal and D(N) = -N if M(N) is a terminating decimal.
# 
# For example, ΣD(N) for 5 ≤ N ≤ 100 is 2438.
# 
# Find ΣD(N) for 5 ≤ N ≤ 10000.

require 'common'

#by simple calculus we have that the maximum is reached in x=(N/e), so we have to check only two values.
def find_k(n)
    e = 2.71828183    
    x = n.to_f / e
    a = x.floor
    b = x.ceil
    t = ((1+1.to_f / a)**a) * b # simple way to check which of [a,b] gives a better value
    return b if n >= t
    return a
end

def is_terminating?(n,k)
    t = k / n.gcd(k)
    [2,5].each do |p|
	while t % p == 0
	    t /= p
	end
    end
    return t == 1
end

def d(n)
    return ((is_terminating?(n,find_k(n)))?(-1):(1))*n
end

max = 10000
puts (5..max).collect{|n| d(n)}.sum
