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

class Traveller
    def initialize(max_depth, alarm_at)
        @location = [0,0]
        @direction = :up     
        @depth = 0
        @max_depth = max_depth
        @steps = 0
        @alarm_at = alarm_at
    end  
    def move
        case @direction
        when :up then     @location[1] += 1
        when :down then   @location[1] -= 1
        when :right then  @location[0] += 1
        when :left then   @location[0] -= 1
        end
        @steps += 1
        puts @steps if @steps % 10**6 == 0
        raise "alarm reached, location = #{@location.inspect}" if @steps == @alarm_at
    end
    def turn_left
        case @direction
            when :up then     @direction = :left
            when :down then   @direction = :right
            when :right then  @direction = :up
            when :left then   @direction = :down
        end      
    end
    def turn_right
        case @direction
            when :up then     @direction = :right
            when :down then   @direction = :left
            when :right then  @direction = :down
            when :left then   @direction = :up
        end      
    end
    def a_movement
        #aRbFR
        @depth += 1
        a_movement unless @depth >= @max_depth
        turn_right
        b_movement unless @depth >= @max_depth
        move
        turn_right
        @depth -= 1
    end
  def b_movement
      #LFaLb
      @depth += 1
      turn_left
      move
      a_movement unless @depth >= @max_depth
      turn_left
      b_movement unless @depth >= @max_depth
      @depth -= 1
  end
  def begin_movement
      #Fa
      move
      a_movement
  end
end

begin
    puts Traveller.new(50,10**12).begin_movement
rescue RuntimeError => info
    puts info
end