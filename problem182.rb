# The RSA encryption is based on the following procedure:
# 
# Generate two distinct primes p and q.
# Compute n=pq and φ=(p-1)(q-1).
# Find an integer e, 1<e<φ, such that gcd(e,φ)=1.
# 
# A message in this system is a number in the interval [0,n-1].
# A text to be encrypted is then somehow converted to messages (numbers in the interval [0,n-1]).
# To encrypt the text, for each message, m, c=m^(e) mod n is calculated.
# 
# To decrypt the text, the following procedure is needed: calculate d such that ed=1 mod φ, then for each encrypted message, c, calculate m=c^(d) mod n.
# 
# There exist values of e and m such that m^(e) mod n=m.
# We call messages m for which m^(e) mod n=m unconcealed messages.
# 
# An issue when choosing e is that there should not be too many unconcealed messages.
# For instance, let p=19 and q=37.
# Then n=19*37=703 and φ=18*36=648.
# If we choose e=181, then, although gcd(181,648)=1 it turns out that all possible messages
# m (0≤m≤n-1) are unconcealed when calculating m^(e) mod n.
# For any valid choice of e there exist some unconcealed messages.
# It's important that the number of unconcealed messages is at a minimum.
# 
# Choose p=1009 and q=3643.
# Find the sum of all values of e, 1<e<φ(1009,3643) and gcd(e,φ)=1, so that the number of unconcealed messages for this value of e is at a minimum.

#It can be proved that for a given e,there are exactly gcd(p-1,e-1)*gcd(q-1,e-1) unconcealed elements
require 'common'
p = 1009
q = 3643
phi = (q-1)*(p-1)

values = (2...phi).find_all{|e| puts e; e.gcd(phi) == 1}.collect{|e|puts e;  [e,((p-1).gcd(e-1)*(q-1).gcd(e-1))]}
min = values.collect{|x| x[1]}.min
puts values.find_all{|x| x[1] == min}.collect{|x| x[0]}.sum