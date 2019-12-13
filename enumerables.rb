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

  def my_inject(*injector)
    return to_enum unless block_given?

    inj_arr = injector + self
    return inj_arr if inj_arr.empty? || length == 1

    result = inj_arr[0]
    inj_arr[1..-1].my_each { |i| result = yield(result, i) }
    print result
  end


end

def multiply_els(arr)
  arr.my_inject(:*)
end

(1..5).my_each {|x| print x}

[1, 2, 3, 4, 5].my_each { |x| print x*2 }