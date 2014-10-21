require 'spec_helper'
require 'data_structures'

describe Structures::Stack do
  before do
    @empty_stack = Structures::Stack.new
    @stack = Structures::Stack.new('John', 'Sally')
  end

  it 'should inherit basic functionality from SinglyLinkedList' do
    sll = Structures::SinglyLinkedList.new('John', 'Sally').to_s
    sll.must_equal Structures::Stack.new('John', 'Sally').to_s
  end

  it 'should be able to push elements onto the stack' do
    @empty_stack.push('John')
    @empty_stack.head.value == 'John'
  end

  it 'should be able to reference the head without going through nodes' do
    @stack.first.must_equal 'Sally'
  end

  it 'should return nil if there are no elements when first is queried' do
    @empty_stack.first.must_be_nil
  end

  it 'should remove the head and return it when the stack is popped' do
    @stack.pop.must_equal 'Sally'
    @stack.first.must_equal 'John'
  end

  it 'should raise an error if pop is called on empty stack' do
    -> { @empty_stack.pop }.must_raise Structures::Stack::EmptyStackError
  end
end
