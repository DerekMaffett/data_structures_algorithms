require 'spec_helper'
require 'data_structures'

describe Structures::HashTable do
  before do
    @empty_hash_table = Structures::HashTable.new(1000)
    @hash_table = Structures::HashTable.new
    @hash_table.set('Steve', 'Apple Computers')
  end

  describe '#hash' do
    it 'gives an appropriate additive hash for a given key' do
      @empty_hash_table.hash('ab').must_equal 195
    end
  end

  describe 'setting and getting' do
    it 'should give an error if a key is not a string for #set' do
      -> { @empty_hash_table.set(89, 9234) }.must_raise Structures::HashKeyError
    end
    it 'should give an error if a key is not a string for #get' do
      -> { @empty_hash_table.get(89) }.must_raise Structures::HashKeyError
    end

    it 'should successfully retrieve a set k/v pair' do
      @hash_table.get('Steve').must_equal 'Apple Computers'
    end

    it 'should return nil when k/v pair is not found' do
      @hash_table.get('Bill').must_be_nil
    end

    it 'should get appropriate values given collisions' do
      @empty_hash_table.set('cc', 'Correct Value')
      @empty_hash_table.set('bd', 'Collision Value')
      @empty_hash_table.get('cc').must_equal 'Correct Value'
      @empty_hash_table.get('bd').must_equal 'Collision Value'
    end

    it 'should reset a k/v pair' do
      @hash_table.set('Steve', 'Microsoft')
      @hash_table.get('Steve').must_equal 'Microsoft'
    end
  end

  describe '#size' do
    it 'empty hash table should have size of 0' do
      @empty_hash_table.size.must_equal 0
    end

    it 'hash table with entries should have a correct size' do
      @hash_table.size.must_equal 1
      @hash_table.set('Bill', 'Microsoft')
      @hash_table.size.must_equal 2
    end

    it 'reseting a k/v pair should not change the size' do
      @hash_table.set('Steve', 'Microsoft')
      @hash_table.size.must_equal 1
    end

    it 'setting an entry to nil removes it from the table' do
      @hash_table.size.must_equal 1
      @hash_table.set('Steve', nil)
      @hash_table.size.must_equal 0
    end
  end

  # describe 'should work appropriately under real-life conditions' do
  #   it 'should handle large data sets' do
  #     dict_size = nil
  #     File.open('/usr/share/dict/words', 'r') do |f|
  #       lines = f.readlines
  #       dict_size = lines.size
  #       lines.each { |line| @empty_hash_table.set(line, line.reverse) }
  #     end
  #     File.open('/usr/share/dict/words', 'r') do |f|
  #       lines = f.readlines
  #       lines.each do |line|
  #         @empty_hash_table.get(line).must_equal line.reverse
  #       end
  #     end

  #     @empty_hash_table.size.must_equal dict_size
  #     @empty_hash_table.allocation.must_equal 128_000

  #     @empty_hash_table.each do |k, _v|
  #       @empty_hash_table.set(k, nil)
  #     end

  #     @empty_hash_table.size.must_equal 0
  #   end
  # end
end
