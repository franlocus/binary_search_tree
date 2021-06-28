class Tree
    attr_accessor :root

    def initialize(array)
        @sorted_array = array.uniq.sort
        @root = build_tree(@sorted_array, 0, @sorted_array.size - 1)
    end

    def build_tree(array, start_index, end_index)
        return if start_index > end_index

        mid = (start_index + end_index) / 2
        root = Node.new(array[mid])
        root.left = build_tree(array, start_index, mid - 1)
        root.right = build_tree(array, mid + 1, end_index)
        root
    end

    def insert(value, root = @root)
        return  Node.new(value) if root.nil?
        raise "That value already exist." if value == root.data

        if value < root.data
            root.left =  insert(value, root.left)
        else
            root.right = insert(value, root.right)
        end
        root
    end

    def delete(value, root = @root)
        return if root.nil?

        if value < root.data
            root.left =  delete(value, root.left)
        elsif value > root.data
            root.right = delete(value, root.right)
        else 
        # The value is same as root's value, then this is the node to be deleted.
            # Node with none or 1 children.
            if root.left.nil?
                temp = root.right
                root = nil
                return temp
            elsif root.right.nil?
                temp = root.left
                root = nil
                return temp
            end
            # Node with 2 children.
            temp = inorder_successor(root.right) 
            root.data = temp.data
            root.right = delete(temp.data, root.right)
        end
        root
    end

    def find(value)
        current = @root
        until value == current.data
            value < current.data ? current = current.left : current = current.right

            raise "Sorry, that value doesn't exist." if current.nil?
        end
        current
    end

    def level_order
        level_order = []
        queue = Array.new(1) { @root }
        until queue.empty?
            current = queue.first
            queue.push(current.left) unless current.left.nil?
            queue.push(current.right) unless current.right.nil?
            level_order.push(queue.shift)
        end
        level_order.map(&:data)
    end

    def level_order_rec
        @queue_level = []
        [*0..height(@root)].each { |level| enqueue_level(@root, level) }
        @queue_level
    end

    def enqueue_level(root, level)
        return if root.nil?
        
        if level == 1
            @queue_level << root.data
        elsif level > 1
            enqueue_level(root.left, level - 1)
            enqueue_level(root.right, level - 1)
        end
    end

    def inorder_successor(root)
        current = root
        current = current.left until current.left.nil?
        current
    end

    def inorder(root = @root)
        return if root.nil?

        inorder(root.left).to_a + [root.data] + inorder(root.right).to_a
    end

    def preorder(root = @root)
        return if root.nil?

        [root.data] + preorder(root.left).to_a + preorder(root.right).to_a
    end

    def postorder(root = @root)
        return if root.nil?

        postorder(root.left).to_a +  postorder(root.right).to_a + [root.data]
    end

    def height(node)
        return 0 if node.nil?

        left_h = height(node.left)
        right_h = height(node.right)

        return [left_h, right_h].max + 1
    end

    def depth(node)
        current = @root
        counter = 0
        until node == current.data
            node < current.data ? current = current.left : current = current.right
            counter += 1
            raise "Sorry, that node doesn't exist." if current.nil?
        end
        counter
    end

    def balanced?
        (height(@root.left) - height(@root.right)).abs <= 1
    end
    
    def rebalance
        @root = build_tree(inorder, 0, inorder.size - 1) unless balanced?
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end
