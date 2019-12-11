# frozen_string_literal: true

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


letters = %w[a b c d e f g h i j]
num = Array.new(10) {rand(1...10)}
letters.my_each_with_index {|x, y| print "[#{x}, #{y}] "}
num.my_each_with_index {|x, y| print "[#{x}, #{y}] "}