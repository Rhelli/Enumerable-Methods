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
    while y < self.length
      yield(self[y], y)
      y += 1
    end
    self
  end

  def my_select
    temp = []
    my_each do |j|
      yield(j) ? temp.push(j) : next
    end
    temp
  end

  def my_all?
    valid = true
    my_each do |k|
      yield(k) ? next : valid = false

      break
    end
    print valid
  end

  def my_any?
    bool = false
    my_each do |any|
      yield(any) ? bool = true : break
    end
    print bool
  end

  def my_none?
    non_test = true
    my_each do |none|
      if !yield(none)
        non_test = true
      else non_test = false
      end
    end
    print non_test
  end

  def my_count?
    count = 0
    my_each do
      count += 1
    end
    print count
  end
end

array = [1, 2, 4, 2]
array.my_count? { |x| print x % 2==0 }