# frozen_string_literal: true

require './enumerables.rb'

RSpec.describe Enumerable do
  let(:rand_arr) { Array.new(10) { rand(1..20) } }
  let(:set_arr) { [1, 2, 3, 4, 5] }
  let(:empt_arr) { [] }
  let(:word_arr) { %w[ant bear cat] }
  let(:nil_arr) { [nil, true, 99] }
  let(:range) { (5..10) }
  describe '#my_each' do
    it 'returns to enumerator if no block given' do
      expect(rand_arr.my_each).to be_an Enumerator
    end

    it 'returns self when passed a block' do
      expect(rand_arr.my_each { |x| x }).to eql(rand_arr)
    end
  end

  describe '#my_each_with_index' do
    it 'returns to enumerator if no block given' do
      expect(rand_arr.my_each_with_index).to be_an Enumerator
    end

    it 'returns self with index if block given' do
      expect(set_arr.my_each_with_index { |x, y| x + y }).to eql(set_arr)
    end
  end

  describe '#my_select' do
    it 'returns to enumerator if no block given' do
      expect(rand_arr.my_select).to be_an Enumerator
    end

    it 'returns an array of elements for which the given block equal true' do
      expect(set_arr.my_select(&:even?)).to eql([2, 4])
    end
  end

  describe '#my_all?' do
    it 'returns true if no block passed and no list items are nil or false' do
      expect(empt_arr.my_all?).to be_truthy
    end

    it 'returns true if block never returns false or nil' do
      expect(set_arr.my_all? { |x| x.is_a?(Integer) })
    end

    it 'passes each element of the collection to the given block' do
      expect(word_arr.my_all? { |word| word.length >= 3 }).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if block ever returns a value other than false or nil' do
      expect(empt_arr.my_any?).to be_falsey
    end

    it 'if no block passed, returns true if at least one collection member is not false or nil' do
      expect(nil_arr.my_any?).to be_truthy
    end

    it 'passes each element of the collection to the given block' do
      expect(word_arr.my_any? { |word| word.length >= 4 }).to be_truthy
    end
  end

  describe '#my_none?' do
    it 'returns true if block never returns true for all elements' do
      expect(word_arr.my_none? { |word| word.length == 5 }).to be_truthy
    end

    it 'if no block given, returns true if no collection members are true' do
      expect(nil_arr.my_none?).to be_truthy
    end
  end

  describe '#my_count' do
    it 'returns the number of items in the collection' do
      expect(rand_arr.my_count).to eql(rand_arr.count)
    end

    it 'returns the number of items equal to a given argument' do
      expect(set_arr.my_count(3)).to eql(set_arr.count(3))
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of running the block once for every element' do
      expect((1..4).my_map { |x| x * x }).to eql([1, 4, 9, 16])
    end
  end

  describe '#my_inject' do
    context 'when there is no initial accumulator value' do
      it 'combines the elements of the list using the initial value as the initial accumularor' do
        expect(range.my_inject { |acc, x| acc + x }).to eql(45)
      end

      it 'combines the elements of the list using the named method specified by the symbol' do
        expect(range.my_inject(:+)).to eql(45)
      end
    end

    context 'when there is an initial accumulator value given' do
      it 'when a block is specified, each element and the accumulator is passed to the block' do
        expect(range.my_inject(1) { |acc, x| acc * x }).to eql(151_200)
      end

      it 'passes each element to the named method of the memo if given a symbol' do
        expect(%w[dog cat mouse dragon].inject do |memo, word|
          memo.length > word.length ? memo : word
        end).to eql('dragon')
      end
    end
  end
end
