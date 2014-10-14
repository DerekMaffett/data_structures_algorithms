# Patch for implementing custom sorting algorithms on arrays
class Array
  def insertion_sort
    each_with_index do |hold, i|
      until hold >= self[i - 1] || i == 0
        self[i] = self[i - 1]
        i -= 1
      end
      self[i] = hold
    end
  end
end
