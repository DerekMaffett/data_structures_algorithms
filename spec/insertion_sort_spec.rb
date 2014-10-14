require 'spec_helper'
require 'insertion_sort'

describe Array do
  it 'should return a sorted array with insertion sort' do
    [1, 32, 4, 7, 42, 16].insertion_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
end
