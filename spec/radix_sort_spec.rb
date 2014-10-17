require 'spec_helper'
require 'sort'

describe Array do
  it 'should return a sorted array with insertion sort' do
    [1, 32, 4, 7, 42, 16].radix_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
  # it 'should sort an inverse array' do
  #   (1..10).to_a.reverse.radix_sort.must_equal((1..10).to_a)
  # end
  # it 'should return same array if array is sorted' do
  #   (1..10).to_a.radix_sort.must_equal((1..10).to_a)
  # end
  # it 'should sort a shuffled array' do
  #   (1..10).to_a.shuffle.radix_sort.must_equal((1..10).to_a)
  # end
end
