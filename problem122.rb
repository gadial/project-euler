# The most naive way of computing n^(15) requires fourteen multiplications:
# 
# n × n × ... × n = n^(15)
# 
# But using a "binary" method you can compute it in six multiplications:
# 
# n × n = n^(2)
# n^(2) × n^(2) = n^(4)
# n^(4) × n^(4) = n^(8)
# n^(8) × n^(4) = n^(12)
# n^(12) × n^(2) = n^(14)
# n^(14) × n = n^(15)
# 
# However it is yet possible to compute it in only five multiplications:
# 
# n × n = n^(2)
# n^(2) × n = n^(3)
# n^(3) × n^(3) = n^(6)
# n^(6) × n^(6) = n^(12)
# n^(12) × n^(3) = n^(15)
# 
# We shall define m(k) to be the minimum number of multiplications to compute n^(k); for example m(15) = 5.
# 
# For 1 ≤ k ≤ 200, find ∑ m(k).

require 'common'
# $fVal = [nil, 0, 1, 2, 2, 3, 3, 4, 3, 4, 4, 5, 4, 5, 5, 5, 4, 5, 5, 6, 5, 6, 6, 6, 5, 6, 6, 6, 6, 7, 6]
$fVal = [nil,0,1]
def upper_bound(n)
    return 0 if n <= 1
    result = n.proper_divisors.collect{|d| f(d)+f(n / d)}.min
    result = upper_bound(n-1)+1 if result == nil
    return result
end
def lower_bound(n)
    ((n / 2)...n).collect{|x| f(x)+1}.min
end
class Seeker
    def initialize(n)
	@n = n
	@upper_bound = upper_bound(n)
	@lower_bound = lower_bound(n)
    end
    def recurse(current_set)
	return @upper_bound if current_set.size > @upper_bound
	if current_set.include?(@n)
	    return @lower_bound if (current_set.size - 1) == @lower_bound
	    @upper_bound = current_set.size - 1
	    return @upper_bound
	end
	t = current_set.last
	return current_set.collect{|x| recurse(current_set+[x+t])}.min
    end
    def run
	recurse([1])
    end

end

def f(n)
    return $fVal[n] unless $fVal[n] == nil
    count = Seeker.new(n).run
    $fVal[n] = count
    return count
end
puts (1..20).collect{|x| f(x)}.inspect
# puts (1..200).inject(0){|sum,x| puts x; sum+f(x)}
# (1...$fVal.length).each{|x| puts "#{x}: upper_bound = #{upper_bound(x)}, lower bound = #{lower_bound(x)}, real value = #{$fVal[x]}"}
