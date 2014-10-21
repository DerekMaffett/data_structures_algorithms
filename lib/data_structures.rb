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
      @head = Node.new(val, head)
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
end
