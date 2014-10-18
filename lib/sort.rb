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

  def radix_sort(msd_index = nil)
    rad_sort = Proc.new do |array, msd_index|
      msd_index ||= array.find_msd
      msd_index -= 1
      buckets = array.fill_buckets(array, msd_index)
      buckets.each do |bucket_name, contents|
        if contents.size > 1 && msd_index > 0
          buckets[bucket_name] = contents.radix_sort(msd_index)
        end
      end
      result = collapse_buckets(buckets, [*0..9].map(&:to_s))
    end

    if msd_index
      rad_sort.call(self, msd_index)
    else
      do_within_radix(msd_index, rad_sort)
    end
  end

  def collapse_buckets(buckets, order)
    order.reduce([]) { |result, bucket| result += buckets[bucket] }
  end

  def do_within_radix(msd_index, radix_proc)
    array = to_radix
    result = radix_proc.call(array, msd_index)
    result.reverse_radix
  end

  def array_split
    map { |ele| [ele] }
  end

  def reverse_radix
    map { |ele| ele.reverse.to_i }
  end

  def to_radix
    map { |ele| ele.to_s.reverse }
  end

  def find_msd
    reduce { |memo, ele| memo.length > ele.length ? memo : ele }.length
  end

  def fill_buckets(array, msd_index)
    buckets = Hash.new { |h, k| h[k] = [] }
    array.each do |num|
      if num[msd_index]
        buckets[num[msd_index]].push(num)
      else
        buckets['0'].push(num)
      end
    end
    buckets
  end
end
