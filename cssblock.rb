### Functional Features:
# Immutable values
# No side-effects
# Higher-order functions
# Currying
# Recursion
# Lazy-evaluation
require 'pry'
require 'csv'

class CssBlock
  attr_reader :selector, :properties

  def initialize(selector, properties = {})
    @selector = selector.dup.freeze
    @properties = properties.dup.freeze
  end

  def set(key, value = nil)
    new_properties = if key.is_a?(Hash)
                       key
                     elsif !value.nil?
                       {
                           key => value
                       }
                     else
                       raise "Either provide a Hash of values, or a key and value"
                     end
    self.class.new(self.selector, self.properties.merge(new_properties))
  end

  def to_s
    serialised_properties = self.properties.inject([]) do |acc, (k, v)|
      acc + ["#{k}: #{v}"]
    end

    "#{self.selector} { #{serialised_properties.join("; ") } }"
  end
end

test =  CssBlock.new("#some_id .class a").set({ "color" => "#000", "text-decoration" => "underline"}).set("color", "Time new roman")
puts test
# => "#some_id .class a { color: #000; text-decoration: underline }"csv

class AnnualWeather

  Reading = Struct.new(:date, :high, :low) do
    def mean
      (high + low)/ 2.0
    end
  end

  def initialize(file_name)
    @readings = []
    CSV.foreach(file_name, header: true) do |row|
      @readings << Reading.new( Date.parse(row[2]), row[10].to_f, row[11].to_f )
    end
  end

  # def mean
  #   return 0.0 if @readings.size.zero?
  #
  #   total = @readings.reduce(0.0) do |sum, reading| # the initialize value of the reduction is 0.0
  #     sum + readings.high + reading.low/ 2.0
  #   end
  #
  #   total / @readings.size.to_f
  # end
end

def text_transfer(txt, key)
  al = ('a'..'z').to_a
  # puts al
  result = []
  txt.length.times do |c|
    d = txt[c]
    al.find_index(d).nil? ? result << ' ' : result << al[al.find_index(d) -  key]

  end
  result.join
end

puts text_transfer('the quick brown fox jumps over the lazy dog', 3)

puts "HAPPY NEW YEARS 2016"