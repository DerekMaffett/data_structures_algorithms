# Patch for implementing custom sorting algorithms on arrays
class Array
  def insertion_sort!
    each_with_index do |hold, i|
      until hold >= self[i - 1] || i == 0
        self[i] = self[i - 1]
        i -= 1
      end
      self[i] = hold
    end
  end

  def merge_sort
    return self if size == 1

    left, right = self[0...size / 2].merge_sort, self[size / 2..-1].merge_sort
    merge(left, right)
  end

  def merge(left, right)
    merged_array = []
    i = 0
    until left.size == 0 || right.size == 0
      merged_array[i] = left[0] <= right[0] ? left.shift : right.shift
      i += 1
    end
    merged_array + (right.empty? ? left : right)
  end
end
