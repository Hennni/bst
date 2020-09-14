class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
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
      root = Node.new(build_arr[mid_index])
      root.left = build_tree(build_arr[0...mid_index])
      root.right = build_tree(build_arr[mid_index + 1..-1])
    elsif build_arr.length == 2
      root = Node.new(build_arr[0])
      root.left = nil
      root.right = Node.new(build_arr[1])
    elsif build_arr.length == 1
      root = Node.new(build_arr[0])
    else
      return nil
    end
    root
  end

  def insert(root = @root, value)
    if root.data == value
      return root if root.data == value
    elsif root.data < value && root.right.nil?
      root.right = Node.new(value)
    elsif root.data > value && root.left.nil?
      root.left = Node.new(value)
    elsif root.data < value
      root.right = insert(root.right, value)
    else
      root.left = insert(root.left, value)
    end

    root
  end

  def min_value_node(node)
    current = node
    while current.left != nil
      current = current.left
    end
    current
  end

  def find(root = @root, value)
    return nil if root.nil?
    if root.data == value
      return root
    elsif value > root.data
      root.right = find(root.right, value)
    elsif value < root.data
      root.left = find(root.left, value)
    end
  end

  def delete(root = @root, value)
    return root if root.nil?

    if value < root.data
      root.left = delete(root.left, value)
    elsif value > root.data
      root.right = delete(root.right, value)
    else
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      else
        temp = min_value_node(root.right)
        root.data = temp.data
        root.right = delete(root.right, temp.data)
      end
    end
    root
  end
end

new_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

p new_tree.find(7)
