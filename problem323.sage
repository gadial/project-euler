#Let y0, y1, y2,... be a sequence of random unsigned 32 bit integers
#(i.e. 0 <= yi < 232, every value equally likely).

#For the sequence xi the following recursion is given:

    #x0 = 0 and
    #xi = xi-1 | yi-1, for i > 0. ( | is the bitwise-OR operator)

#It can be seen that eventually there will be an index N such that xi = 232 -1 (a bit-pattern of all ones) for all i >= N.

#Find the expected value of N.
#Give your answer rounded to 10 digits after the decimal point.

#This can be modelled by a simple Markov chain with 33 states (for the number of 1's) and solved using the standard 
#method of computing mean hitting time in a discrete Markov chain, which amounts to solving a linear equation.
total_number_of_bits = 32

def transition_probability(a,b):
	#b-a is the number of bits that should come up as "1" in the upcoming random vector
	zero_bits = total_number_of_bits-a
	return (1/2)^(zero_bits)*binomial(zero_bits, b-a) #binomial distribution

states = range(total_number_of_bits + 1)
goal_state = total_number_of_bits

A = Matrix(QQ, len(states))
for i in states:
	if i != goal_state:
		for j in states:
			A[i,j] = -transition_probability(i,j)
	A[i,i] = A[i,i] + 1

vec = [1 for s in states]
vec[goal_state] = 0
b = vector(QQ,vec)
print A.solve_right(b)[0].n(digits = 11)