module Enumerable
  def my_each
    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
    self
  end
end


array = Array.new(20) {rand(1...50)}
array.my_each {|x| print "#{x}! "}