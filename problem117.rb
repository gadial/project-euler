# Using a combination of black square tiles and oblong tiles chosen from: red tiles measuring two units, green tiles measuring three units, and blue tiles measuring four units, it is possible to tile a row measuring five units in length in exactly fifteen different ways.
# 
# How many ways can a row measuring fifty units in length be tiled?
# 
# NOTE: This is related to problem 116.

#similar, but we won't copy much code

$Vals=[1]
$Tiles = [2,3,4]
def F(n)
    return 0 if n < 0
    return $Vals[n] unless $Vals[n] == nil
    count = $Tiles.inject(F(n-1)){|sum, m| sum+F(n-m)}
    $Vals[n] = count
    return count
end

puts F(50)
