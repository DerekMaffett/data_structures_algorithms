require 'spec_helper'
require 'sort'

describe Array do
  it 'merge sort should return a sorted array with insertion sort' do
    [1, 32, 4, 7, 42, 16].merge_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'merge sort should sort an inverse array' do
    (1..10).to_a.reverse.merge_sort.must_equal((1..10).to_a)
  end
  it 'merge sort should return same array if array is sorted' do
    (1..10).to_a.merge_sort.must_equal((1..10).to_a)
  end
  it 'merge sort should sort a shuffled array' do
    (1..10).to_a.shuffle.merge_sort.must_equal((1..10).to_a)
  end
  it 'iterative merge sort should return a sorted array' do
    [1, 32, 4, 7, 42, 16].iterative_merge_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'iterative merge sort should sort an inverse array' do
    (1..10).to_a.reverse.iterative_merge_sort.must_equal((1..10).to_a)
  end
  it 'iterative merge sort should return same array if array is sorted' do
    (1..10).to_a.iterative_merge_sort.must_equal((1..10).to_a)
  end
  it 'iterative merge sort should sort a shuffled array' do
    (1..10).to_a.shuffle.iterative_merge_sort.must_equal((1..10).to_a)
  end
end
