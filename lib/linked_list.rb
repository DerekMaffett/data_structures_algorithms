Node = Struct.new(:value, :nexxt)

class Node
  def to_s_adapter
    # klass = self.value.class
    # case klass
    # when String
    #   "'#{self.value}'"
    # when Symbol
    #   ":#{self.value}"
    # else
    #   "#{self.value}"
    # end

    if self.value.class == String
      string = "'#{self.value}'"
    elsif self.value.class == Symbol
      string = ":#{self.value}"
    else
      string = "#{self.value}"
    end
  end
end

class SinglyLinkedList
  attr_accessor :head, :size

  def initialize(*args)
    @size = 0
    args.each { |arg| insert(arg) }
  end

  def insert(val)
    @head = Node.new(val, self.head)
    @size += 1
  end

  # Always return the node just *prior* to the search criteria, or prior to
  # the final nil reference. Note that this still does not handle edge cases.
  def node_before(search_crit)
    current_node = @head

    until current_node.nexxt.nil?
      if current_node.nexxt.value == search_crit
        return current_node
      else
        current_node = current_node.nexxt
      end
    end
    current_node
  end

  # Returns nil if no result was found during the node_before, otherwise
  # the correct node
  def search(search_crit)
    return @head if @head.value == search_crit
    node_before(search_crit).nexxt
  end

  def remove(search_crit)
    if @head.value == search_crit
      deleted_node = @head
      @head = @head.nexxt
    else
      previous_node = node_before(search_crit)
      deleted_node = previous_node.nexxt
      return nil if previous_node.nexxt.nil?
      previous_node.nexxt = previous_node.nexxt.nexxt
    end
    deleted_node
  end

  def to_s
    result = ''
    each do |node|
      result += "#{node.to_s_adapter}, "
    end
    result.gsub(/, \Z/, '')
  end

  def each
    current_node = @head
    until current_node.nil?
      yield(current_node)
      current_node = current_node.nexxt
    end
  end
end
