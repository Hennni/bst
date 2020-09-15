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

  def level_order(root = @root)
    level_arr = []
    node_queue = []
    node_queue.unshift(root)
    until node_queue.empty?
      current = node_queue[-1]
      level_arr.push(current.data)
      node_queue.unshift(current.left) unless current.left.nil?
      node_queue.unshift(current.right) unless current.right.nil?
      node_queue.pop
    end
    level_arr
  end

  def inorder(root = @root, arr = [])
    return root if root.nil?

    if root.left
      inorder(root.left, arr)
      arr << root.data
    elsif root.left.nil?
      arr << root.data
    end
    if root.right
      inorder(root.right, arr)
    end
    arr
  end

  def preorder(root = @root, arr = [])
    return root if root.nil?

    arr << root.data
    if root.left
      preorder(root.left, arr)
    end
    if root.right
      preorder(root.right, arr)
    end
    arr
  end

  def postorder(root = @root, arr = [])
    return root if root.nil?

    if root.left
      postorder(root.left, arr)
    end
    if root.right
      postorder(root.right, arr)
    end
    arr << root.data

    arr
  end

  def height(root = @root)
    return 0 if root.nil?

    node_queue = []
    height = 0
    node_queue.unshift(root)

    until node_queue.empty?
      size = node_queue.length

      while size.positive?
        front = node_queue.pop
        node_queue.unshift(front.left) if front.left
        node_queue.unshift(front.right) if front.right
        size -= 1
      end
      height += 1
    end
    height - 1
  end

  def depth(root = @root, counter = 0, node)
    return root if root.nil?

    current = root.data
    if current == node
      counter
    elsif node < current
      counter += 1
      depth(root.left, counter, node)
    elsif node > current
      counter += 1
      depth(root.right, counter, node)
    else
      'Not here'
    end
  end

  def balanced?(root = @root)
    return nil if root.nil?

    lheight = height(root.left) if root.left
    rheight = height(root.right) if root.right
    return false if (lheight - rheight) > 1 || (rheight - lheight) > 1

    true
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

new_tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

p new_tree.balanced?

new_tree.insert(8)

p new_tree.balanced?

new_tree.insert(9)

p new_tree.balanced?