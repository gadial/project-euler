require 'miller-rabin'
max = 10**7

temp = [true]*max

temp[0] = false
temp[1] = false

current = 1
while current < max
	puts 100*current.to_f / max
	current += 1
	next if temp[current] == false
	pos = 2*current
	while pos < max
		temp[pos] = false
		pos += current
	end
end

primes = (0..max).find_all{|i| temp[i]}


# primes = (2..max).find_all{|n| puts(100*n.to_f / max); n.prime?}

File.open("primes.txt", "w"){|file| file.write(primes.inspect.delete("[]"))}