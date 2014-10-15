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

  def merge(l, r)
    merged_array = []
    merged_array.push(l[0] <= r[0] ? l.shift : r.shift) while l.first && r.first
    merged_array + (r.empty? ? l : r)
  end
end
