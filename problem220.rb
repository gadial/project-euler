#Let D_(0) be the two-letter string "Fa". For n≥1, derive D_(n) from D_(n-1) by the string-rewriting rules:
#
#"a" → "aRbFR"
#"b" → "LFaLb"
#
#Thus, D_(0) = "Fa", D_(1) = "FaRbFR", D_(2) = "FaRbFRRLFaLbFR", and so on.
#
#These strings can be interpreted as instructions to a computer graphics program, with "F" meaning "draw forward one unit", "L" meaning "turn left 90 degrees", "R" meaning "turn right 90 degrees", and "a" and "b" being ignored. The initial position of the computer cursor is (0,0), pointing up towards (0,1).
#
#Then D_(n) is an exotic drawing known as the Heighway Dragon of order n. For example, D_(10) is shown below; counting each "F" as one step, the highlighted spot at (18,16) is the position reached after 500 steps.
#
#What is the position of the cursor after 10^(12) steps in D_(50) ?
#Give your answer in the form x,y with no spaces.

#Undoubtly the worst, ugliest piece of code written for this project. It still works.

$Values = {}
def move(direction, location)
    case direction
    when :up then     location[1] += 1
    when :down then   location[1] -= 1
    when :right then  location[0] += 1
    when :left then   location[0] -= 1
    end
end
def turn_left(direction)
    case direction
	when :up then     return :left
	when :down then   return :right
	when :right then  return :up
	when :left then   return :down
    end      
end
def turn_right(direction)
    case direction
	when :up then     return :right
	when :down then   return :left
	when :right then  return :down
	when :left then   return :up
    end      
end

def seek(n,steps)
    def recurse_a(n,steps,location,direction)
    #    aRbFR	
	return location if steps == 0
	if n>0
	    return recurse_a(n-1,steps,location,direction) if steps <= step_a(n-1,direction)[2]
	    direction, location_offset, steps_offset = step_a(n-1,direction)
	    location[0]+=location_offset[0]; location[1]+=location_offset[1]; 
	    steps -= steps_offset
	    return location if steps == 0
	end
	direction = turn_right(direction)
	if n>0
	    return recurse_b(n-1,steps,location,direction) if steps <= step_b(n-1,direction)[2]
	    direction, location_offset, steps_offset = step_b(n-1,direction)
	    location[0]+=location_offset[0]; location[1]+=location_offset[1]; 
	    steps -= steps_offset
	    return location if steps == 0
	end
	move(direction,location)
	steps -= 1
	return location if steps == 0
	direction = turn_right(direction)
	raise "very strange"	
    end
    
    def recurse_b(n,steps,location,direction)
    #    LFaLb
	return location if steps == 0
	direction = turn_left(direction)
	move(direction,location)
	steps -= 1
	return location if steps == 0
	if n>0
	    return recurse_a(n-1,steps,location,direction) if steps <= step_a(n-1,direction)[2]
	    direction, location_offset, steps_offset = step_a(n-1,direction)
	    location[0]+=location_offset[0]; location[1]+=location_offset[1]; 
	    steps -= steps_offset
	    return location if steps == 0
	end
	direction = turn_left(direction)
	return recurse_b(n-1,steps,location,direction) if n>0 and steps <= step_b(n-1,direction)[2]
	return location if steps == 0
	raise "very strange"	
    end
    
    location = [0,1]
    steps -= 1
    direction = :up
    recurse_a(n,steps,location,direction)
end

def step_a(n, direction)
#    aRbFR
    return $Values[[:a,n,direction]] unless $Values[[:a,n,direction]] == nil
    old_direction = direction
    location = [0,0]
    if n == 0
	direction = turn_right(direction)
	move(direction,location)
	direction = turn_right(direction)
	$Values[[:a,n,old_direction]] = [direction,location.dup,1]
	return [direction,location.dup,1]
    end
    # n > 0
    direction, offset, steps = step_a(n-1,direction)
    location[0] += offset[0]; location[1] += offset[1]
    direction = turn_right(direction)
    direction, offset, more_steps = step_b(n-1,direction)
    steps += more_steps
    location[0] += offset[0]; location[1] += offset[1]
    move(direction,location)
    steps += 1
    direction = turn_right(direction)
    $Values[[:a,n,old_direction]] = [direction,location.dup,steps]
    return [direction,location.dup,steps]
end

def step_b(n, direction)
#    LFaLb
    old_direction = direction
    location = [0,0]
    return $Values[[:b,n,direction]] unless $Values[[:b,n,direction]] == nil
    if n == 0
	direction = turn_left(direction)
	move(direction,location)
	direction = turn_left(direction)
	$Values[[:b,n,old_direction]] = [direction,location.dup,1]
	return [direction,location.dup,1]
    end
    # n > 0
    direction = turn_left(direction)
    move(direction,location)
    steps = 1
    direction, offset, more_steps = step_a(n-1,direction)
    steps += more_steps
    location[0] += offset[0]; location[1] += offset[1]
    direction = turn_left(direction)
    direction, offset, more_steps = step_b(n-1,direction)
    steps += more_steps
    location[0] += offset[0]; location[1] += offset[1]
    $Values[[:b,n,old_direction]] = [direction,location.dup,steps]
    return [direction,location.dup,steps]
end

puts seek(50,10**12).inspect
