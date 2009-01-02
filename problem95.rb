# The proper divisors of a number are all the divisors excluding the number itself. For example, the proper divisors of 28 are 1, 2, 4, 7, and 14. As the sum of these divisors is equal to 28, we call it a perfect number.
# 
# Interestingly the sum of the proper divisors of 220 is 284 and the sum of the proper divisors of 284 is 220, forming a chain of two numbers. For this reason, 220 and 284 are called an amicable pair.
# 
# Perhaps less well known are longer chains. For example, starting with 12496, we form an amicable chain of five numbers:
# 
# 12496 14288 15472 14536 14264 ( 12496 ...)
# 
# Find the smallest member of the longest amicable chain with no element exceeding one million.
require 'common'
$SumOfProperDivisors = File.open("sum_of_proper_divisors.txt","r"){|file| file.read.split.collect{|s| s.to_i}}
puts "Opened divisors file..."
class Integer
  def next_amicable
#     proper_divisors.sum+1
	$SumOfProperDivisors[self-1]
  end
end

def find_for_n(n, chain_length,max)
	puts "now working on #{n}"
	current = n
	steps = 1
	while current <= max and chain_length[current] == nil
		chain_length[current] = :occupied
		current = current.next_amicable
# 		puts "12496 found while checking #{n}" if current == 12496
#  		puts "moved to #{current}"
		steps += 1
	end
	circle_start = current
# 	puts "circle_start = #{current}"
	current = n
	while current != circle_start
		steps -= 1
		chain_length[current] = -1
		current = current.next_amicable
	end
	steps -= 1
	steps.times {chain_length[current] = steps; current = current.next_amicable}
# 	puts "chain_length[#{n}]=#{chain_length[n]}"
end

chain_length = []
max = 10**6
# 
(1..max).each do |n|
	find_for_n(n, chain_length,max)
end

# File.open("temp.txt", "w"){|file| file.write(chain_length.inspect)}

# find_for_n(9464, chain_length,max)
max = chain_length.compact.max
puts "max = #{max}"
element = chain_length.index(max)
puts "first element = #{element}"
chain = [element]
current = element.next_amicable
while current != element
	puts "current = #{current}"
	chain << current
	current = current.next_amicable
end
puts chain.min

# # chain = (1...max).collect{|x| puts x; x.next_amicable}
# lengths = {}
# (1...max).each{|x| lengths[x] = 0}
# 
# puts "done"
# 
# (1...max).each do |start|
# 	puts "now working on #{start}"
# 	current_chain = [start]
# 	next unless lengths[start] == 0
# 
# 	next_element = start.next_amicable
# 	while not current_chain.include?(next_element)
# 		if lengths[next_element] != 0
# 			break
# 		else
# 			current_chain << next_element
# 		end
# 		next_element = next_element.next_amicable
# # 		puts "current_chain: #{current_chain.inspect}, next = #{next_element}"
# 	end
# 	breakpoint = current_chain.index(next_element)
# 	if breakpoint == nil
# 		current_chain.each_index{|i| lengths[current_chain[i]] = (lengths[next_element] || 0) + current_chain.length - i}
# 	else
# 		cycle_length = current_chain.length - breakpoint
# 		current_chain.each_index{|i| lengths[current_chain[i]] = [current_chain.length - i,cycle_length].max}
# 	end
# end
# 
# # puts lengths.to_a.sort{|a,b| b[1] <=> a[1]}.inspect
# best_chain = [lengths.to_a.sort{|a,b| b[1] <=> a[1]}.first[0]]
# next_element = best_chain.last.next_amicable
# while not best_chain.include?(next_element)
# 	best_chain << next_element
# 	next_element = best_chain.last.next_amicable
# end
# 
# puts best_chain.inspect
# puts best_chain.min
# 
# # for i in (1...max)
# #   next if chain_length[i] != nil
# #   puts i
# #   current_chain = [i, i.next_amicable]
# #   while current_chain.first != current_chain.last
# #     current_chain << current_chain.last.next_amicable
# #   end
# #   current_chain.pop
# #   value = ((current_chain.exists?{|x| x>=max})?(current_chain.length):(0))
# #   current_chain.each{|j| chain_length[j]=current_chain.length}
# # end
# 
# puts chain_length.index(chain_length.max)