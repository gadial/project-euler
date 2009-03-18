# A printing shop runs 16 batches (jobs) every week and each batch requires a sheet of special colour-proofing paper of size A5.
# 
# Every Monday morning, the foreman opens a new envelope, containing a large sheet of the special paper with size A1.
# 
# He proceeds to cut it in half, thus getting two sheets of size A2. Then he cuts one of them in half to get two sheets of size A3 and so on until he obtains the A5-size sheet needed for the first batch of the week.
# 
# All the unused sheets are placed back in the envelope.
# 
# At the beginning of each subsequent batch, he takes from the envelope one sheet of paper at random. If it is of size A5, he uses it. If it is larger, he repeats the 'cut-in-half' procedure until he has what he needs and any remaining sheets are always placed back in the envelope.
# 
# Excluding the first and last batch of the week, find the expected number of times (during each week) that the foreman finds a single sheet of paper in the envelope.
# 
# Give your answer rounded to six decimal places using the format x.xxxxxx .

#by linearity of expectation, it is enough to sum on the probabilities that we end up with a single A2 paper, a single A3 paper etc.
require 'common'

$Values = {}
def prob_for(n,sheets)
    sig = [n]+sheets
    return $Values[sig] if $Values[sig]
    return 1.0 if sheets.length == 1 and sheets[0] == n
    return 0.0 if sheets.min > n
    result = sheets.collect_with_index do |k,i| 
	    temp = sheets.dup
	    temp.delete_at(i)
	    ((k+1)..5).each{|t| temp << t}
	    prob_for(n,temp)
    end.sum
    result /= sheets.length
    $Values[sig] = result
    return result
end

sheets = [2,3,4,5]
printf("%.6f\n",(2..4).collect{|n| prob_for(n,sheets)}.sum)
