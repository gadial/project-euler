require 'common'
class Integer
  def prime?
    (2...self).each{|x| return false if (self % x) == 0}
    true
  end
end

range = 50

# 100.times do
#   x,y,d = rand(range), rand(range), rand(range)
#   next unless (x**2+d*y**2) % 4 == 0
#   p = (x**2+d*y**2) / 4
#   puts "x=#{x}, y=#{y}, d=#{d}, p=#{p}" if p.prime?
# end

puts compute_jacobi_symbol(-43,