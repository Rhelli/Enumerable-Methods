# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    if is_a?(Array)
      while x < length
        yield(self[x])
        x += 1
      end
    else
      each_arr = to_a
      while x < each_arr.length
        yield(each_arr[x])
        x += 1
      end
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    is_a?(Array) ? self : to_a
    y = 0
    while y < length
      yield(self[y], y)
      y += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    is_a?(Array) ? self : to_a
    temp = []
    my_each do |j|
      yield(j) ? temp.push(j) : next
    end
    temp
  end

  def my_all?
    if block_given?
      is_a?(Array) ? self : to_a
      valid = true
      my_each do |k|
        yield(k) ? next : valid = false
      end
      valid
    else
      my_each { |x| falise if x.nil? || x == false }
    end
  end

  def my_any?
    return false if empty?

    if block_given?
      bool = false
      my_each do |any|
        yield(any) ? bool = true : next
      end
      bool
    else
      my_each { |x| return true unless x.nil? }
    end
  end

  def my_none?
    if !block_given?
      my_each { |x| return true if x == true }
    else
      non_test = true
      my_each { |none| !yield(none) ? non_test : non_test = false }
    end
    non_test
  end

  def my_count(val = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !val.nil?
      my_each { |j| count += 1 if self[j] == val }
    else
      count = length
    end
    count
  end

  def my_map(&proc)
    map_arr = []
    block_given? ? my_each { |x| map_arr.push(yield(x)) } : my_each { |y| map_arr.push(proc.call(y)) }
    map_arr
  end

  def my_inject(accumulator = nil, &block)
    accumulator = accumulator.to_sym if accumulator.is_a?(String) && !block_given?
    if accumulator.is_a?(Symbol)
      block = accumulator.to_proc
      accumulator = nil
    end
    my_each { |x| accumulator = accumulator.nil? ? x : block.yield(accumulator, x) }
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end
