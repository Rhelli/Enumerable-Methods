# frozen_string_literal: true

require './enumerables.rb'

RSpec.describe Enumerable do
  let(:rand_arr) { Array.new(10) { rand(1..20) } }
  let(:set_array) { [1, 2, 3, 4, 5] }
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
      expect(set_array.my_each_with_index { |x, y| ("#{x}, #{y}")}).to eql(set_array)
    end
  end

  describe "#my_select" do
    it "returns to enumerator if no block given" do
      expect(rand_arr.my_select).to be_an Enumerator
    end

    it "returns an array of elements for which the given block equal true" do
      expect(set_array.my_select { |x| x.even? }).to eql([2, 4])
    end
  end

  describe "#my_all?" do
    it "returns true if no block passed and no list items are nil or false" do
      expect([].my_all?).to be_truthy
    end

    it "returns true if block never returns false or nil" do
      expect(set_array.my_all? { |x| x.is_a?(Integer)})
    end
  end

  describe "#my_none" do
    it "returns true if block never returns true for all elements" do
      expect ()
    end
  end
end
