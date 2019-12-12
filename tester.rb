def my_inject(memo=self[0])
  self.each_with_index do |value, index|
    memo = yield(memo, value) if index > 0
  end
  print memo
end

print [5, 6, 7, 8, 9, 10].inject(1) { |product, n| product * n }

def my_inject(injector = self[0])
  return to_enum unless block_given?

  my_each_with_index do |v, i|
    injector = yield(injector, v) if i.positive?
  end
  print injector
end