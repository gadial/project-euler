# For any two strings of digits, A and B, we define F_(A,B) to be the sequence (A,B,AB,BAB,ABBAB,...) in which each term is the concatenation of the previous two.
# 
# Further, we define D_(A,B)(n) to be the n^(th) digit in the first term of F_(A,B) that contains at least n digits.
# 
# Example:
# 
# Let A=1415926535, B=8979323846. We wish to find D_(A,B)(35), say.
# 
# The first few terms of F_(A,B) are:
# 1415926535
# 8979323846
# 14159265358979323846
# 897932384614159265358979323846
# 14159265358979323846897932384614159265358979323846
# 
# Then D_(A,B)(35) is the 35^(th) digit in the fifth term, which is 9.
# 
# Now we use for A the first 100 digits of π behind the decimal point:
# 14159265358979323846264338327950288419716939937510
# 58209749445923078164062862089986280348253421170679
# 
# and for B the next hundred digits:
# 82148086513282306647093844609550582231725359408128
# 48111745028410270193852110555964462294895493038196 .
# 
# Find Σ_(n=0,1,...,17) 10^(n)× D_(A,B)((127+19n)×7^(n)) .

A = "1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679"
B = "8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196"

#a little brute-force, but there's no need for optimizations
def find_digit_in_sequence(term_number, digit_number, a,b)
    return a[digit_number..digit_number] if term_number == 0
    return b[digit_number..digit_number] if term_number == 1
    lengths = [a.length, b.length]
    (term_number-1).times {lengths << lengths[-1]+lengths[-2]}
    return find_digit_in_sequence(term_number-2,digit_number,a,b) if lengths[-3] > digit_number
    return find_digit_in_sequence(term_number-1,digit_number-lengths[-3],a,b)
end

def d(n,a,b)
    lengths = [a.length, b.length]
    while lengths.last < n
	lengths << lengths[-1]+lengths[-2]
    end
    find_digit_in_sequence(lengths.length - 1,n-1,a,b)
end
17.downto(0){|n| print d((127+19*n)*(7**n),A,B)}
puts