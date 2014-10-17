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

    mid = size / 2
    left, right = self[0...mid].merge_sort, self[mid..-1].merge_sort
    merge(left, right)
  end

  def merge(l, r)
    return l unless r # Inserted for the sake of iterative merge_sort

    merged_array = []
    merged_array.push(l[0] <= r[0] ? l.shift : r.shift) while l[0] && r[0]
    merged_array + (r.empty? ? l : r)
  end

  # Developed along with the ruby on rails dev class
  def iterative_merge_sort


    array = self.map { |e| [e] }
    array = array.each_slice(2).map { |l, r| merge(l, r) } while array.size > 1
    array.flatten
  end
end
