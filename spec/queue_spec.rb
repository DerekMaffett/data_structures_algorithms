require 'spec_helper'
require 'data_structures'

describe Structures::Queue do
  before do
    @queue = Structures::Queue.new('John', 'Abby', 'Yuna')
    @empty_queue = Structures::Queue.new
  end

  it 'should track a tail (last) element' do
    @empty_queue.last.must_be_nil
  end

  it 'should track a head (first) element' do
    @empty_queue.first.must_be_nil
  end

  describe '#enqueue' do
    it 'adding to an empty queue should add to the front of the queue' do
      @empty_queue.enqueue 'John'
      @empty_queue.first.must_equal 'John'
    end

    it 'should set first element to last on initial insert' do
      @empty_queue.enqueue('John').last.must_equal @empty_queue.first
    end

    it 'adding a series of items should track the head and tail correctly' do
      @queue.first.must_equal 'John'
      @queue.last.must_equal 'Yuna'
    end
  end

  describe '#dequeue' do
    it 'removing from an empty queue raises an exception' do
      -> { @empty_queue.dequeue }.must_raise Structures::EmptyQueueError
    end

    it 'removing from a queue returns the first (head) value' do
      @queue.dequeue.must_equal 'John'
    end

    it 'removing from a queue changes the head to the next node' do
      @queue.dequeue
      @queue.first.must_equal 'Abby'
    end

    it 'can cleanly remove head' do
      3.times { @queue.dequeue }
      @queue.first.must_be_nil
    end

    it 'can cleanly remove tail' do
      3.times { @queue.dequeue }
      @queue.last.must_be_nil
    end
  end

  describe 'reporting size' do
    it 'has a size of 0 when empty' do
      @empty_queue.size.must_equal 0
    end

    it 'has a size of 0 when all elements are removed' do
      3.times { @queue.dequeue }
      @queue.size.must_equal 0
    end

    it 'has a size in keeping with its number of elements' do
      @queue.size.must_equal 3
    end
  end
end
