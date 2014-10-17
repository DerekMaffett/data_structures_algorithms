require 'sort'
require 'spec_helper'

describe Array do
  it 'has benchmarks for different sorting algorithms' do
    sorts = [
      :insertion_sort!,
      :merge_sort,
      :iterative_merge_sort,
      :quicksort!
    ]
    puts "\n"
    sorts.each do |sort|
      puts CustomBenchmarker.new(sort).benchmark
    end
  end
end
