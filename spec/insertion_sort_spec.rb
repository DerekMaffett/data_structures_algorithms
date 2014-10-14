require 'spec_helper'
require 'insertion_sort'
require 'benchmark'

describe Array do
  it 'should return a sorted array with insertion sort' do
    [1, 32, 4, 7, 42, 16].insertion_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'should sort an inverse array' do
    (1..10).to_a.reverse.insertion_sort.must_equal (1..10).to_a
  end
  it 'should return same array if array is sorted' do
    (1..10).to_a.insertion_sort.must_equal (1..10).to_a
  end
  it 'should sort a shuffled array' do
    (1..10).to_a.shuffle.insertion_sort.must_equal (1..10).to_a
  end
  it 'is benchmarked' do
    best = Benchmark.measure { (1..1000).to_a.insertion_sort }
    random = Benchmark.measure { (1..1000).to_a.shuffle.insertion_sort }
    worst = Benchmark.measure { 1000.downto(1).to_a.insertion_sort }

    puts "Best case: #{best}"
    puts "Random case: #{random}"
    puts "Worst case: #{worst}"
  end
end
