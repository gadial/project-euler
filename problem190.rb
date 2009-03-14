# Let S_(m) = (x_(1), x_(2), ... , x_(m)) be the m-tuple of positive real numbers with x_(1) + x_(2) + ... + x_(m) = m for which P_(m) = x_(1) * x_(2)^(2) * ... * x_(m)^(m) is maximised.
# 
# For example, it can be verified that [P_(10)] = 4112 ([ ] is the integer part function).
# 
# Find Σ[P_(m)] for 2 ≤ m ≤ 15.
require 'common'

def proportion(k)
    #it can be shown (e.g. with Lagrange multipliers) that in the optimal solution we have:
    #x_k = x_1*(1+1/1)(1+1/2)...(1+1/(k-1))
    (1...k).collect{|x| 1+1.to_f / x}.prod
end

def find_x1(m)
     temp = (1..m).collect{|k| proportion(k)}.sum
     m.to_f / temp
end

def find_p(m)
    x1 = find_x1(m)
    (1..m).collect{|k| (x1*proportion(k))**k}.prod
end

puts (2..15).collect{|m| find_p(m).to_i}.sum