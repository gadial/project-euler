#Find the sum of all the multiples of 3 or 5 below 1000. 
puts (1...1000).inject(0){|sum, x| (x % 3 == 0 or x % 5 == 0)?(sum+x):(sum)}
