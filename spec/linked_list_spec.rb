require 'spec_helper'
require 'linked_list'

describe SinglyLinkedList do
  before do
    @list = SinglyLinkedList.new('John', 'Sally', 'Yuna')
  end

  it 'should initialize with optional node argument' do
    list = SinglyLinkedList.new('John')
    list.head.must_be_instance_of Node
    list.head.value.must_equal 'John'
    list.head.nexxt.must_be_nil
  end

  it 'should initialize with multiple node arguments' do
    list = SinglyLinkedList.new('John', 'Sally')
    list.head.value.must_equal 'Sally'
    list.head.nexxt.must_be_instance_of Node
    list.head.nexxt.value.must_equal 'John'
  end

  it 'should insert a node at the head of a list' do
    list = SinglyLinkedList.new
    list.insert('John')
    list.head.must_be_instance_of Node
    list.head.value.must_equal 'John'
    list.head.nexxt.must_be_nil
  end

  it 'should have size 0 for a new list' do
    SinglyLinkedList.new.size.must_equal 0
  end

  it 'should report its size for a list with nodes' do
    SinglyLinkedList.new('John', 'Sally').size.must_equal 2
  end

  it 'should search nodes for a value and report that value' do
    search_result = @list.search('John')
    search_result.must_be_instance_of Node
    search_result.value.must_equal 'John'
  end

  it 'should return nil if search fails' do
    @list.search('Abby').must_be_nil
  end

  it 'should return first item in search' do
    @list.search(@list.head.value).must_equal @list.head
  end

  it 'should remove a node' do
    @list.remove('Sally').value.must_equal 'Sally'
    @list.search('Sally').must_be_nil
    @list.size.must_equal 2
  end

  it 'should return nil if node to be removed does not exist' do
    @list.remove('Abby').must_be_nil
  end

  it 'should reasign the head if head is removed' do
    @list.head.value.must_equal 'Yuna'
    @list.remove(@list.head.value)
    @list.head.value.must_equal 'Sally'
  end

  it 'should print a list of nodes' do
    @list.to_s.must_equal "'Yuna', 'Sally', 'John'"
  end

  it 'should format correctly for various inputs' do
    list = SinglyLinkedList.new(42, 'string', :task, 1000)
    list.to_s.must_equal "1000, :task, 'string', 42"
  end
end
