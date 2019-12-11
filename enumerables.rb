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
    y = 0
    while y < length
      yield(self[y], y)
      y += 1
    end
    self
  end

  def my_select
    temp = Array.new
    self.my_each do |j|
      temp.push(j) ? yield(j) : false
      end
    temp
  end
end

letters = %w[a b c d e f g h i j]
num = Array.new(10) {rand(1...10)}
num.my_select {|j| print if j % 2 == 0}