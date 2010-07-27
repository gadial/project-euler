# -*- coding: utf-8 -*-

class Point:
  def __init__(self,x,y):
    self.x = x
    self.y = y
  def __repr__(self):
    return "(" + str(self.x) + ", " + str(self.y) + ")"

class Line:
  def __init__(self,m,n):
    self.m = m
    self.n = n
  
  def __repr__(self):
    return "y = " + str(self.m) + "x + " + str(self.n)

  @classmethod
  def from_points(self, p1,p2):
    m = (p1.y-p2.y)/(p1.x-p2.x)
    return Line.from_slope_and_point(m,p1)
  
  @classmethod
  def from_slope_and_point(self,m,p):
    n = p.y - m*p.x
    return Line(m,n)

  def reflect_along_at(self,rhs,p):
    m1 = self.m
    m2 = rhs.m
    tan_alpha = (m1-m2)/(1+m1*m2)
    m = (m2-tan_alpha)/(1+m2*tan_alpha)
    return Line.from_slope_and_point(m,p)
    
def normal_at(p):
    m = p.y / (4*p.x)
    return Line.from_slope_and_point(m,p)

def find_other_intersection(line, p):
  m = line.m
  n = line.n
  b = (2*m*n)/(4+m**2)
  x = -b - p.x
  y = m*x+n
  return Point(x,y)

#old_p = Point(0,101/10)
#new_p = Point(14/10,-96/10)

old_p = Point(0,10.1)
new_p = Point(1.4,-9.6)


count = 0
while not (abs(new_p.x) <= 1/100 and new_p.y > 0):
  count += 1
  line = Line.from_points(old_p,new_p)
  new_line = line.reflect_along_at(normal_at(new_p),new_p)
  old_p = new_p
  new_p = find_other_intersection(new_line,old_p)

print count
