# Let r be the remainder when (a−1)^(n) + (a+1)^(n) is divided by a^(2).
# 
# For example, if a = 7 and n = 3, then r = 42: 6^(3) + 8^(3) = 728 ≡ 42 mod 49. And as n varies, so too will r, but for a = 7 it turns out that r_(max) = 42.
# 
# For 3 ≤ a ≤ 1000, find ∑ r_(max).

#using Newton's binom we can easily show that when n is even we have (a−1)^(n) + (a+1)^(n) = 2 (mod a^2)
#and when n is odd we have (a−1)^(n) + (a+1)^(n) = 2na (mod a^2)
#in other words, the possible values for r_max are of the form ka (mod a^2) where k is even
#it suffices to check k<a^2
require 'common'
def find_r_max(a)
    (2...a*a).reject{|k| k.odd?}.collect{|k| (k*a) % (a*a)}.max
end

puts (3..1000).collect{|a| puts a; find_r_max(a)}.sum