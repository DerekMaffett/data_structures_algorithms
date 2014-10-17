require 'spec_helper'
require 'sort'
require 'benchmark'

describe Array do
  it 'should return a sorted array with quicksort' do
    [1, 32, 4, 7, 42, 16].quicksort.must_equal [1, 4, 7, 16, 32, 42]
  end
  it 'should sort an inverse array with quicksort' do
    [*1..10].reverse.quicksort.must_equal([*1..10])
  end
  it 'should return same array if array is sorted with quicksort' do
    [*1..10].quicksort.must_equal([*1..10])
  end
  it 'should sort a shuffled array with quicksort' do
    [*1..10].shuffle.quicksort.must_equal([*1..10])
  end
  it 'is benchmarked' do
    best = Benchmark.measure { (1..1000).to_a.quicksort }
    random = Benchmark.measure { (1..1000).to_a.shuffle.quicksort }
    worst = Benchmark.measure { 1000.downto(1).to_a.quicksort }
    all_same = Benchmark.measure { Array.new(1000) { 5 }.quicksort }

    puts 'Quicksort:'
    puts "Best case: #{best}"
    puts "Random case: #{random}"
    puts "Worst case: #{worst}"
    puts "All same: #{all_same}"
  end
end
