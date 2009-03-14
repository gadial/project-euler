# We shall call a positive integer A an "Alexandrian integer", if there exist integers p, q, r such that:
# A = p · q · r    and   A^(-1)=p^(-1)+q^(-1)+r^(-1)

# For example, 630 is an Alexandrian integer (p = 5, q = ?7, r = ?18). In fact, 630 is the 6^(th) Alexandrian integer, the first 6 Alexandrian integers being: 6, 42, 120, 156, 420 and 630.

# Find the 150000^(th) Alexandrian integer.

#can be reduced to finding p>=q>0 such that r=(pq-1)/(p+q) is integer (and then the Alexandrian number is pqr).

#This can be reduced to the following: given p, find all the q's such that (p+q) divides p^2+1

target = 150000
max = 200000
# target = 6
# max = 100
nums = []
p  = 1
while nums.length < max
	p +=1 
	t = p**2 + 1
	(2..p).each do |k| 
	    if t % k == 0
		q = (t / k) - p
		r = (p*q-1) / (p+q)
# 		puts "p=#{p}, q=#{q}, r=#{r}, pqr = #{p*q*r}"
		nums << p*q*r
		nums.uniq!
		puts nums.length
	    end
	end
end

# File.open("temp","w"){|file| file.write(nums.inspect)}
puts nums.uniq.sort[target-1]
# puts nums.uniq.sort.inspect

# count = 0
# p,q=2,1
# nums = []
# while nums.length < max
# # while count < max
#     if (p*q-1) % (p+q) == 0
#         r = (p*q-1) / (p+q)
#         # puts "p=#{p}, q=#{q}, r=#{r}"
#         nums << p*q*r
#         puts nums.length
#         # count +=1
#         # puts count
#     end
#     q += 1
#     if q>p
#         q = 1
#         p += 1
#     end
# end
# File.open("temp","w"){|file| file.write(nums.inspect)}
# puts nums.sort[target-1]