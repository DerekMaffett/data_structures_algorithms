class Array
  def insertion_sort
    self.each_with_index do |hold, i|
      until self[i] >= self[i - 1] || i == 0
        swap(i)
        i -= 1
      end
    end
  end

  def swap(i)
    self[i - 1], self[i] = self[i], self[i -1]
  end

  # My current attempt at a comparison insertion sort. Not currently functional.
  # def insertion_sort
  #   self.each_with_index do |hold, i|
  #     k = 0
  #     while i - k > 0 && hold <= self[i - k]
  #       puts k
  #       k += 1
  #     end
  #     self.delete_at(i)
  #     self.insert(i - k, hold)
  #   end
  #   self
  # end
end
