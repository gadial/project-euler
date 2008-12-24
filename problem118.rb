# Using all of the digits 1 through 9 and concatenating them freely to form decimal integers, different sets can be formed. Interestingly with the set {2,5,47,89,631}, all of the elements belonging to it are prime.
# 
# How many distinct sets containing each of the digits one through nine exactly once contain only prime elements?
require 'common'
require 'miller-rabin'
$Vals = {[] => 1}

def primes_by_permutation(digits)
    digits.collect{|d| d.to_s}.all_permutations.collect{|p| p.join("").to_i}.find_all{|n| n.prime?}.length
end

def prime_sets_on_digits(digits)
    return $Vals[digits] unless $Vals[digits] == nil
    temp_digits = digits.dup
    first = temp_digits.pop
    count = temp_digits.all_subsets.inject(0) do |sum,subset|
	sum + (primes_by_permutation(subset + [first])*prime_sets_on_digits(temp_digits - subset))
    end
    $Vals[digits] = count
    return count
end

digits = [1,2,3,4,5,6,7,8,9]
puts prime_sets_on_digits(digits)