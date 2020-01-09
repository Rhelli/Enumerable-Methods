# frozen_string_literal: true

require './enumerables.rb'

RSpec.describe Enumerable do
  let(:rand_arr) { Array.new(10) { rand(1..20) } }
  let(:set_arr) { [1, 2, 3, 4, 5] }
  let(:empt_arr) { [] }
  let(:word_arr) { ['ant', 'bear', 'cat'] }
  let(:nil_arr) { [nil, true, 99]}
  describe "#my_each" do
    it "returns to enumerator if no block given" do
      expect(rand_arr.my_each).to be_an Enumerator
    end

    it "returns self when passed a block" do
      expect(rand_arr.my_each { |x| x }).to eql(rand_arr)
    end
  end

  describe "#my_each_with_index" do
    it "returns to enumerator if no block given" do
      expect(rand_arr.my_each_with_index).to be_an Enumerator
    end

    it "returns self with index if block given" do
      expect(set_arr.my_each_with_index { |x, y| ("#{x}, #{y}")}).to eql(set_arr)
    end
  end

  describe "#my_select" do
    it "returns to enumerator if no block given" do
      expect(rand_arr.my_select).to be_an Enumerator
    end

    it "returns an array of elements for which the given block equal true" do
      expect(set_arr.my_select { |x| x.even? }).to eql([2, 4])
    end
  end

  describe "#my_all?" do
    it "returns true if no block passed and no list items are nil or false" do
      expect(empt_arr.my_all?).to be_truthy
    end

    it "returns true if block never returns false or nil" do
      expect(set_arr.my_all? { |x| x.is_a?(Integer)})
    end

    it "passes each element of the collection to the given block" do
      expect(word_arr.my_all? { |word| word.length >= 3 }).to eql(true)
    end
  end

  describe "#my_any?" do
    it "returns true if block ever returns a value other than false or nil" do
      expect(empt_arr.my_any?).to be_falsey
    end

    it "if no block passed, returns true if at least one collection member is not false or nil" do
      expect(nil_arr.my_any?).to be_truthy
    end

    it "passes each element of the collection to the given block" do
      expect(word_arr.my_any? { |word| word.length >= 4}).to be_truthy
    end
  end
end
