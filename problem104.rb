# The Fibonacci sequence is defined by the recurrence relation:
# 
#     F_(n) = F_(n−1) + F_(n−2), where F_(1) = 1 and F_(2) = 1.
# 
# It turns out that F_(541), which contains 113 digits, is the first Fibonacci number for which the last nine digits are 1-9 pandigital (contain all the digits 1 to 9, but not necessarily in order). And F_(2749), which contains 575 digits, is the first Fibonacci number for which the first nine digits are 1-9 pandigital.
# 
# Given that F_(k) is the first Fibonacci number for which the first nine digits AND the last nine digits are 1-9 pandigital, find k.

#It suffices to find which of the Fibonacci numbers are last pandigital; it's much easier to find them since we are only interested in the first 9 digits
#When we find a last pandigital number, we calculate the "real" number via the direct formula, and check if it is first pandigital as well
#Since we're only interested in the first nine digits, we don't need the direct calculation to be precise

x, real_x = 1, 1
y, real_y = 1, 1
n = 3
while true
    puts n    
    x, y = y, (x+y)%10**9
    real_x, real_y = real_y, real_x + real_y
    break if y.last_pandigital? and real_y.first_pandigital?
    n += 1
end
