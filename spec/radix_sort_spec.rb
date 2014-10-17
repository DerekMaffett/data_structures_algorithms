require 'spec_helper'
require 'sort'

describe Array do
  it 'should return a sorted array with radix sort' do
    [1863, 30452, 4231, 755, 44112, 146].radix_sort.must_equal(
      [146, 755, 1863, 4231, 30452, 44112])
  end
  it 'should sort an inverse array with radix sort' do
    (1..10).to_a.reverse.radix_sort.must_equal((1..10).to_a)
  end
  # it 'should return same array if array is sorted with radix sort' do
  #   (1..10).to_a.radix_sort.must_equal((1..10).to_a)
  # end
  # it 'should sort a shuffled array with radix sort' do
  #   (1..10).to_a.shuffle.radix_sort.must_equal((1..10).to_a)
  # end
end
