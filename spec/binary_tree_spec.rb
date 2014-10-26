require 'spec_helper'
require 'data_structures'

describe Structures::BinaryTree do
  before do
    @empty_binary_tree = Structures::BinaryTree.new
    @test_tree =
      Structures::BinaryTree.new(
        'Tim',
        Structures::BinaryTree.new(
          'Jony',
          Structures::BinaryTree.new('Dan', nil, nil),
          Structures::BinaryTree.new(
            'Katie',
            Structures::BinaryTree.new('Peter', nil, nil),
            Structures::BinaryTree.new('Andrea', nil, nil)
          )
        ),
        Structures::BinaryTree.new(
          'Phil',
          Structures::BinaryTree.new('Craig', nil, nil),
          Structures::BinaryTree.new('Eadie', nil, nil)
        )
      )
  end

  describe 'initialize' do
    it 'should be empty on initialization' do
      @empty_binary_tree.value.must_equal nil
    end
  end

  describe 'traversals' do
    it 'should implement pre-order traversal' do
      result = ''
      @test_tree.preorder do |value|
        result += "#{value} "
      end
      result.must_equal 'Tim Jony Dan Katie Peter Andrea Phil Craig Eadie '
    end

    it 'should implement in-order traversal' do
      result = ''
      @test_tree.inorder do |value|
        result += "#{value} "
      end
      result.must_equal 'Dan Jony Peter Katie Andrea Tim Craig Phil Eadie '
    end

    it 'should implement post-order traversal' do
      result = ''
      @test_tree.postorder do |value|
        result += "#{value} "
      end
      result.must_equal 'Dan Peter Andrea Katie Jony Craig Eadie Phil Tim '
    end
  end
end

  #                   Tim

  #      Jony                   Phil

  # Dan       Katie         Craig   Eadie

  #      Peter    Andrea
