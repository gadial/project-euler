#once the formula for S(n,n+d) is found the rest is straightforward

max_range = 10^6
prime_squares = [p^2 for p in prime_range(max_range)]

def count(t):
    result = 0
    if (t % 8) == 0 and t>=16:
        result += 1 # d = 0
    if (t - 5) % 8 == 0 and (t-5)>=16:
        result +=2
    t -= 3
    t -= t % 8
    result += 2*(floor((t-16) / 24)+1)
    return result


#don't really need these two, but they help to understand what's going on
def remainder(d):
    #S(n,n+d) = 8(n-2)+remainder(d)
    if d==0:
        return 5
    return 3+6*d
    
def S(m,n):
    d = abs(m-n)
    bring_empty_square = (m-2)+(n-2)
    walk_by_diagonal = 5+6*(min(m,n)-2)
    if d == 0:
        additional_steps = 0
    else:
        additional_steps = 3+5*(d-1)
    return (bring_empty_square + walk_by_diagonal + additional_steps)

print 2+sum([count(t) for t in prime_squares])