# Given is the function f(x) = ⌊2^(30.403243784-x^(2))⌋ × 10^(-9) ( ⌊ ⌋ is the floor-function),
# the sequence u_(n) is defined by u_(0) = -1 and u_(n+1) = f(u_(n)).
# 
# Find u_(n) + u_(n+1) for n = 10^(12).
# Give your answer with 9 digits after the decimal point.

def f(x)
    (2**(30.403243784-x**2)).floor * 10**(-9)
end
$Vals = {}
u = -1

# n = 10**12
# n.times do |i| 
#     puts i
#     u = f(u)
#     if $Vals[u] != nil
# 	puts "loop at i = #{i}, u=#{u}, seen before at #{$Vals[u]}"
# 	break
#     else
# 	$Vals[u] = i
#     end
# end

516.times {u=f(u)}
puts u + f(u)
