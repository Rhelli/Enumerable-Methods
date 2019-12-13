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
    valid
  end

  def my_any?
    return to_enum unless block_given?

    bool = false
    my_each do |any|
      yield(any) ? bool = true : next
    end
    bool
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
    non_test
  end

  def my_count(val = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif !val.nil?
      my_each { |j| count += 1 if self[j] == val}
    else
      count += 1
    end
    count
  end

  def my_map(&proc)
    map_arr = []
    block_given? ? my_each { |x| map_arr.push(yield(x))} : my_each { |y| map_arr.push(proc.call(y)) }
    map_arr
  end

  def my_inject(accumulator = nil, sym = nil,  &block)
    accumulator = accumulator.to_sym if accumulator.is_a?(String) && !sym && !block_given?
    block, accumulator = accumulator.to_proc, nil if accumulator.is_a?(Symbol) && !sym
    sym = sym.to_sym if sym.is_a?(Symbol)

    my_each { |x| accumulator = accumulator.nil? ? x : block.yield(accumulator, x) }
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end

=begin
[1, 2, 3, 5].my_each { |x| p x }
puts
[1, 2, 3, 5].each { |x| p x } #compare
puts
=end

=begin
[1, 2, 3, 5].my_each_with_index { |x, y| puts "#{x} at #{y}" }
puts
[1, 2, 3, 5].each_with_index { |x, y| puts "#{x} at #{y}" }#compare
puts
=end

=begin
p [1, 2, 3, 4].my_select { |x| x % 2 == 0}
puts
p [1, 2, 3, 4].select { |x| x % 2 == 0 }#compare
puts
=end

=begin
p ['alpha', 'apple', 'allen key'].my_all?{ |x| x[0] == 'a' }
puts
p ['alpha', 'apple', 'allen key'].all?{ |x| x[0] == 'a' }
puts
=end

=begin
p ['lpha', 'apple', 'llen key'].my_any?{ |x| x[0] == 'a' }
puts
p ['lpha', 'pple', 'allen key'].any?{ |x| x[0] == 'a' }
puts
=end

=begin
p ['lpha', 'pple', 'llen key'].my_none?{ |x| x[0] == 'a' }
puts
p ['lpha', 'pple', 'llen key'].none?{ |x| x[0] == 'a' }
puts
=end
=begin
arr = [1, 2, 3, 4]
p arr.my_count { |i| i%2==0}
puts
p arr.count { |i| i%2==0}
puts
=end

=begin
p [1,2,3,4,4,7,7,7,9].my_count { |i| i > 1 }
puts
p [1,2,3,4,4,7,7,7,9].count { |i| i > 1 }
puts
=end



=begin
p [1,2,3,4,4,7,7,7,9].my_map { |i| i*4 }
puts
p [1,2,3,4,4,7,7,7,9].map { |i| i*4 }
puts 
=end

=begin
p [1,2,3,4,4,7,7,7,9].my_inject(0){|running_total, item| running_total + item }
puts
p [1,2,3,4,4,7,7,7,9].inject(0){|running_total, item| running_total + item }
puts 
=end

=begin
p multiply_els([2,4,5])
=end

=begin
my_proc = Proc.new { |i| i*4 }
p [1,2,3,4,4,7,7,7,9].my_map { |i| i*4 }
puts
p [1,2,3,4,4,7,7,7,9].my_map(&my_proc)
=end