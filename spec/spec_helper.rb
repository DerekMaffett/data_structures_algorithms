require 'minitest/spec'
require 'minitest/autorun'
require 'benchmark'

class CustomBenchmarker
  def initialize(sort)
    @benchmarks = {}
    @sort = sort
  end

  def benchmark
    @benchmarks['Ordered'] = execute_benchmark [*1..1000]
    @benchmarks['Random'] = execute_benchmark [*1..1000].shuffle
    @benchmarks['Reverse Ordered'] = execute_benchmark 1000.downto(1).to_a
    @benchmarks['All Same'] = execute_benchmark(Array.new(1000) { 5 })

    output = "#{@sort.capitalize}:\n\n"
    @benchmarks.each do |k, v|
      output += "#{k}: #{v}"
    end
    output += "\n"
  end

  def execute_benchmark(test_array)
    Benchmark.measure { test_array.send(@sort) }
  end
end
