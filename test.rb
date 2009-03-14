require 'mathn'
numbers = []
current = 5
8000.times {numbers << current; current += 2; numbers << current; current += 4}
# puts numbers.inspect

t = Prime.new
p=t.next
while p < numbers.max
    puts p if not numbers.include?(p)
    p = t.next
end