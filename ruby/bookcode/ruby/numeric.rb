#!/usr/bin/env ruby
#Example from the book, appended with some demonstrative code
#Redefining the class Numeric

class Numeric
  def inches
    self
  end
  def feet
    self * 12.inches
  end
  def yards
    self * 3.feet
  end
  def miles
    self * 5280.feet
  end
  def back
    self * -1
  end
  def forward
    self
  end
end

#Example of conversion
a=1245
puts "Inches: #{a}"
puts "Feet: #{a.feet}"
puts "Yards: #{a.yards}"
puts "Miles: #{a.miles}"
puts "Back: #{a.back}"
puts "Forward: #{a.forward}"
puts "Ten miles back: #{10.miles.back}"
puts "Two feet forward: #{2.feet.forward}"
