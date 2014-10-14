require 'spec_helper'
require 'benchmark'
require 'sort'

describe Array do
  it 'should return a sorted array with insertion sort' do
    [1, 32, 4, 7, 42, 16].merge_sort.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'should sort an inverse array' do
    (1..10).to_a.reverse.merge_sort.must_equal(1..10).to_a
  end
  it 'should return same array if array is sorted' do
    (1..10).to_a.merge_sort.must_equal(1..10).to_a
  end
  it 'should sort a shuffled array' do
    (1..10).to_a.shuffle.merge_sort.must_equal(1..10).to_a
  end
  it 'is benchmarked' do
    best = Benchmark.measure { (1..1000).to_a.merge_sort }
    random = Benchmark.measure { (1..1000).to_a.shuffle.merge_sort }
    worst = Benchmark.measure { 1000.downto(1).to_a.merge_sort }
    all_same = Benchmark.measure { Array.new(1000) { 5 }.merge_sort }

    puts 'Merge Sort:'
    puts "Best case: #{best}"
    puts "Random case: #{random}"
    puts "Worst case: #{worst}"
    puts "All same: #{all_same}"
  end
end
