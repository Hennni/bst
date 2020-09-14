class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    build_arr = arr.sort.uniq
    return nil if build_arr.empty?

    if build_arr.length > 2
      mid_index = build_arr.length / 2
      root = TreeNode.new(build_arr[mid_index])
      root.left = build_tree(build_arr[0...mid_index])
      root.right = build_tree(build_arr[mid_index + 1..-1])
    elsif build_arr.length == 2
      root = TreeNode.new(build_arr[0])
      root.left = nil
      root.right = TreeNode.new(build_arr[1])
    elsif build_arr.length == 1
      root = TreeNode.new(build_arr[0])
    else
      return nil
    end
    root
  end
end

new_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

p new_tree
