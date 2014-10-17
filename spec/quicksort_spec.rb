require 'spec_helper'
require 'sort'

describe Array do
  it 'should return a sorted array with quicksort' do
    [1, 32, 4, 7, 42, 16].quicksort!.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'should sort an inverse array with quicksort' do
    [*1..10].reverse.quicksort!.must_equal([*1..10])
  end
  it 'should return same array if array is sorted with quicksort' do
    [*1..10].quicksort!.must_equal([*1..10])
  end
  it 'should sort a shuffled array with quicksort' do
    [*1..10].shuffle.quicksort!.must_equal([*1..10])
  end
end
