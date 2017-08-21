require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  arr = []
  in_order_traversal(tree_node, arr, k)
  arr.last
end

def in_order_traversal(tree_node, arr, k)
  return if tree_node.nil?
  return if arr.length == k - 1
  in_order_traversal(tree_node.left, arr, k)
  arr.push(tree_node)
  in_order_traversal(tree_node.right, arr, k)
end
