# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    while x < length
      yield(self[x])
      x += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    y = 0
    while y < length
      yield(self[y], y)
      y += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    temp = []
    my_each do |j|
      yield(j) ? temp.push(j) : next
    end
    temp
  end

  def my_all?
    return to_enum unless block_given?

    valid = true
    my_each do |k|
      yield(k) ? next : valid = false

      break
    end
    print valid
  end

  def my_any?
    return to_enum unless block_given?

    bool = false
    my_each do |any|
      yield(any) ? bool = true : break
    end
    print bool
  end

  def my_none?
    return to_enum unless block_given?

    non_test = true
    my_each do |none|
      if !yield(none)
        non_test
      else non_test = false
      end
    end
    print non_test
  end

  def my_count
    return to_enum unless block_given?

    count = 0
    my_each do
      count += 1
    end
    print count
  end

  def my_map
    return to_enum unless block_given?

    map_arr = []
    my_each do |x|
      map_arr.push(yield(x))
    end
    map_arr
  end
end
