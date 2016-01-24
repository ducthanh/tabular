### Functional Features:
# Immutable values
# No side-effects
# Higher-order functions
# Currying
# Recursion
# Lazy-evaluation

class ValueHolder
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def bumped
    self.class.new(value + 1)
  end
end



puts ValueHolder.new(0).bumped.bumped.bumped.bumped.value

class ToS

  attr_reader :stringT

  def initialize(string)
    @stringT = string
    string.to_s
  end

  def to_s
    puts "this is #{@stringT} monitor"
  end
end


a = ToS.new("Samsung")
a.to_s