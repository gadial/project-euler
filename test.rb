require 'common'

n = 387
# a = 155
a = 170
puts n.gcd(a)
puts compute_jacobi_symbol(a,n)
puts fast_modular_exponent(a,(n-1)/2, n)