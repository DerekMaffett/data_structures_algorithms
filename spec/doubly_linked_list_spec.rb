require 'spec_helper'
require 'data_structures'

describe Structures::DoublyLinkedList do
  before do
    @empty_list = Structures::DoublyLinkedList.new
    @list = Structures::DoublyLinkedList.new.unshift('John').unshift(
      'Peter').unshift('Kelly')
    @duplicates_list = Structures::DoublyLinkedList.new(1, 1, 1, 2, 3, 4, 5, 5)
    @random_duplicates_list = Structures::DoublyLinkedList.new
    200.times { @random_duplicates_list.unshift(rand(100)) }
  end

  describe '#unshift' do
    it 'should add a node to an empty list' do
      @empty_list.unshift('John').tail.must_equal 'John'
    end

    it 'should add multiple nodes' do
      @list.tail.must_equal('Kelly')
    end
  end

  describe '#each_node' do
    it 'should iterate over nodes' do
      @list.to_s.must_equal 'Kelly Peter John'
    end
  end

  describe '#deduplicate' do
    it 'should remove duplicate nodes' do
      @duplicates_list.deduplicate.to_s.must_equal '5 4 3 2 1'
    end

    it 'should also deduplicate large random data sets' do
      arrayified = @random_duplicates_list.deduplicate.to_s.split(' ')
      arrayified.size.must_equal arrayified.uniq.size
    end
  end
end
