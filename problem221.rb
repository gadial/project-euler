# We shall call a positive integer A an "Alexandrian integer", if there exist integers p, q, r such that:
# A = p · q · r    and   A^(-1)=p^(-1)+q^(-1)+r^(-1)

# For example, 630 is an Alexandrian integer (p = 5, q = ?7, r = ?18). In fact, 630 is the 6^(th) Alexandrian integer, the first 6 Alexandrian integers being: 6, 42, 120, 156, 420 and 630.

# Find the 150000^(th) Alexandrian integer.

#can be reduced to finding p>=q>0 such that r=(pq-1)/(p+q) is integer (and then the Alexandrian number is pqr).

#p and q cannot both be even
target = 150000
max = 250000
count = 0
p,q=2,1
nums = []
while nums.length < max
# while count < max
    if (p*q-1) % (p+q) == 0
        r = (p*q-1) / (p+q)
        # puts "p=#{p}, q=#{q}, r=#{r}"
        nums << p*q*r
        puts nums.length
        # count +=1
        # puts count
    end
    q += 1
    if q>p
        q = 1
        p += 1
    end
end
File.open("temp","w"){|file| file.write(nums.inspect)}
puts nums.sort[target-1]