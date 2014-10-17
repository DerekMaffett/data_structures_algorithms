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
    array = map { |e| [e] }
    array = array.each_slice(2).map { |l, r| merge(l, r) } while array.size > 1
    array.flatten
  end

  def quicksort!
    return self if size <= 1

    pivot_index = pivot_split
    self[0...pivot_index] = self[0...pivot_index].quicksort!
    self[pivot_index + 1..-1] = self[pivot_index + 1..-1].quicksort!

    self
  end

  def pivot_split
    sort_index = 0
    pivot_value = delete_at([*0...size].sample)
    each_with_index do |ele, i|
      if ele < pivot_value
        swap!(i, sort_index)
        sort_index += 1
      end
    end
    insert(sort_index, pivot_value)
    sort_index
  end

  def swap!(i, j)
    self[i], self[j] = self[j], self[i]
  end
end
