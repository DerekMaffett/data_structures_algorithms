require 'active_support'
require 'active_support/core_ext'

module Structures
  Node = Struct.new(:value, :nexxt)

  # The nodes that a singly linked list is made out of
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

      if value.class == String
        "'#{value}'"
      elsif value.class == Symbol
        ":#{value}"
      else
        "#{value}"
      end
    end
  end

  # Class for a singly linked list
  class SinglyLinkedList
    attr_accessor :head, :size

    def initialize(*args)
      @size = 0
      args.each { |arg| insert(arg) }
    end

    def insert(val)
      @head = Node.new(val, @head)
      @size += 1
      self
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
      @size -= 1
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

  class Stack < SinglyLinkedList
    alias_method :push, :insert

    class EmptyStackError < RuntimeError; end

    def first
      @head.try(:value)
    end

    def pop
      fail EmptyStackError unless first
      remove(first).value
    end
  end

  DoublyLinkedNode = Struct.new(:value, :prev, :nexxt)

  class EmptyQueueError < RuntimeError; end

  class Queue
    attr_accessor :head, :tail, :size

    def initialize(*args)
      @size = 0
      args.each { |arg| enqueue(arg) }
    end

    def enqueue(val)
      original_tail = @tail
      @tail = DoublyLinkedNode.new(val, nil, original_tail)
      original_tail.prev = @tail if original_tail
      @head ||= @tail
      @size += 1
      self
    end

    def dequeue
      deleted_value = first
      fail EmptyQueueError unless deleted_value
      @head = @head.prev
      @head.nexxt = nil if @head
      @tail = nil unless @head
      @size -= 1
      deleted_value
    end

    def first
      @head.try(:value)
    end

    def last
      @tail.try(:value)
    end
  end

  class HashKeyError < RuntimeError; end

  class HashNode
    def initialize(key, value, nexxt)
      @key = key
      @value = value
      @nexxt = nexxt
    end

    attr_accessor :key, :value, :nexxt
  end

  class HashLinkedList
      def initialize
        @size = 0
        @head = nil
      end

      attr_reader :size

      def unshift(key, val)
        @head = HashNode.new(key, val, @head)
        @size += 1
        self
      end

      def search(key)
        current_node = @head
        until current_node.nil?
          return current_node if current_node.key == key
          current_node = current_node.nexxt
        end
      end

      def remove(key)
        if @head.key == key
          @head = @head.nexxt
          @size -= 1
          return nil
        end
        current_node = @head
        while current_node.nexxt
          if current_node.nexxt.try(:key) == key
            current_node.nexxt = current_node.nexxt.nexxt
            @size -= 1
            return nil
          end
        end
      end

      def each
        current_node = @head
        until current_node.nil?
          yield(current_node)
          current_node = current_node.nexxt
        end
      end
    end

  class HashTable
    def initialize(allocation)
      @allocation = allocation
      @size = 0
      @buckets = Array.new(@allocation)
    end

    attr_reader :size

    def hash(key)
      key.chars.inject(0) { |accum, c| accum + c.ord }
    end

    def set(key, value)
      fail HashKeyError unless key.is_a? String
      index = hash(key) % @allocation
      @buckets[index] ||= HashLinkedList.new
      return nullify(key, index) if value.nil?
      table_entry = @buckets[index].search(key)
      if table_entry
        table_entry.key = key
        table_entry.value = value
      else
        @buckets[index].unshift(key, value)
        @size += 1
      end
      value
    end

    def get(key)
      fail HashKeyError unless key.is_a? String
      index = hash(key) % @allocation
      return nil unless @buckets[index]
      @buckets[index].search(key).try(:value)
    end

    private

    def nullify(key, index)
      initial_size = @buckets[index].size
      @buckets[index].remove(key)
      @size += @buckets[index].size - initial_size
      nil
    end
  end
end
