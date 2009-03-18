# How many 20 digit numbers n (without any leading zero) exist such that no three consecutive digits of n have a sum greater than 9?
require 'common'
$Values = {}

def f(last_two, remaining_length)
    return $Values[last_two + [remaining_length]] if $Values[last_two + [remaining_length]]
    return 1 if remaining_length == 0
    result = (0..9).reject{|n| (last_two+[n]).sum > 9}.collect{|n| f([last_two.last,n],remaining_length-1)}.sum
    $Values[last_two + [remaining_length]] = result
    return result
end
length = 20
puts (10..99).collect{|n| n.to_s.split("").collect{|x| x.to_i}}.reject{|s| s.sum > 9}.collect {|start| f(start, length-2)}.sum