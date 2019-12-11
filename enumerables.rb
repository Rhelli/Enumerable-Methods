module Enumerable
  def my_each
    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
    self
  end

  def my_each_with_index
    x = 0
    while x < length
      yield(self[x], x)
      x += 1
    end
    self
  end
end


array = Array.new(10) {rand(1...10)}
array.my_each_with_index {|x| print "#{x} "}