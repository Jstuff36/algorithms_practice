require_relative 'bst_node'
require 'byebug'
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    @root = traverse_and_insert(@root, value)
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if tree_node.value == value
    if value > tree_node.value
      result = find(value, tree_node.right)
    else
      result = find(value, tree_node.left)
    end
    result
  end

  def delete(value)
    target_node = find(value)
    if target_node == @root
      @root = nil
      return
    end
    remove(target_node)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    while tree_node.right
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    return 0 if !tree_node.left && !tree_node.right
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?

    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)

    left_depth - right_depth <= 1 && is_balanced?(tree_node.left) &&
      is_balanced?(tree_node.right)

  end

  def in_order_traversal(tree_node = @root, arr = [])
    return if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:

  def traverse_and_insert(root, value)
    return BSTNode.new(value) unless root
    if value > root.value
      root.right = traverse_and_insert(root.right, value)
      root.right.parent = root
    else
      root.left = traverse_and_insert(root.left, value)
      root.left.parent = root
    end
    root
  end

  def remove_node_without_children(node)
    if node.parent
      if node.parent.left == node
        node.parent.left = nil
      else
        node.parent.right = nil
      end
    end
  end

  def node_with_left_child_only(node)
    node.left.parent = node.parent

    if node.parent.left == node
      node.parent.left = node.left
    else
      node.parent.right = node.left
    end
  end

  def node_with_right_child_only(node)
    node.right.parent = node.parent

    if node.parent.left == node
      node.parent.left = node
    else
      node.parent.right = node.right
    end
  end

  def node_with_two_children(node)
    replacement = maximum(node.left)
    node.value = replacement.value
    remove(replacement)
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      remove_node_without_children(node)

    elsif node.left && node.right.nil?
      node_with_left_child_only(node)

    elsif node.right && node.left.nil?
      node_with_right_child_only(node)
    else
      node_with_two_children(node)
    end
  end

end
