# Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
# where each “_” is a single digit.

#simple backtracking
require 'common'

def fits_digits(n, num_of_digits)
    (n.to_i*n.to_i).to_s.length >= num_of_digits and ((n.to_i*n.to_i).to_s[-num_of_digits..-1] =~ Regexp.new("1.2.3.4.5.6.7.8.9.0"[-num_of_digits..-1])) != nil
end

def match(n)
    puts n
    total_digits = "1.2.3.4.5.6.7.8.9.0".length
    if 2*n.length >= total_digits
	if fits_digits(n,total_digits) and (n.to_i * n.to_i).to_s.length == total_digits
	    puts n
	    exit
	else
	    return nil
	end	
    end
    return nil unless fits_digits(n.to_i,n.length)
    (0..9).each{|d| match(d.to_s + n)}
end

match("0")