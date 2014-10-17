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

  def radix_sort(start = true)
    puts "Stringify: #{stringify}"
    puts "Self: #{self}"
    array = start ? stringify : self
    msd_index = array.find_msd - 1
    puts "Sorting by #{msd_index + 1}'s place:"
    buckets = fill_buckets(array, msd_index)
    buckets.each do |bucket_name, contents|
      if contents.size > 1 && msd_index > 0
        buckets[bucket_name] = contents.radix_sort(false)
      end
    end
    sort_order = [*0..9].map(&:to_s)
    result = sort_order.inject([]) { |result, bucket|
      result += buckets[bucket]
      puts "RESULT: #{result}"
      result }
    result.reverse_stringify if start
  end

  def array_split
    map { |ele| [ele] }
  end

  def reverse_stringify
    map { |ele| ele.reverse.to_i }
  end

  def stringify
    map { |ele| ele.to_s.reverse }
  end

  def find_msd
    inject { |memo, ele| memo.length > ele.length ? memo : ele }.length
  end

  def fill_buckets(array, msd_index)
    buckets = Hash.new { |h, k| h[k] = [] }
    puts "\tFilling buckets from array: #{p(array.map(&:reverse))}"
    array.each do |num|

      if num[msd_index]
        puts "\tPutting #{num.reverse} into bucket #{num[msd_index]}"
        buckets[num[msd_index]].push(num)
      else
        buckets['0'].push(num)
      end
    end
    buckets
  end
end
