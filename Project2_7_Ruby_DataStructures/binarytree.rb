class Node

    attr_accessor :leftchild, :rightchild, :value

    def initialize(value)
        @value = value
    end

end

class TreeBuilder

    attr_accessor :root

    def initialize(root=nil)
        @root = Node.new(root)
    end

    def build_tree(array)
        arr = Array.new
        array.each { |i| arr << insert_node(i) }
        arr
    end

    def insert_node(value)
        node = @root

        if node.nil?
            node = Node.new(value)
        else
            insert_node_helper(node,value)
        end
    end

    def insert_node_helper(node, value)
        if (value < node.value)
            if node.leftchild.nil?
                node.leftchild = Node.new(value)
            else
                insert_node_helper(node.leftchild, value)
            end
        elsif (node.value < value)
            if (node.rightchild.nil?)
                node.rightchild = Node.new(value)
            else
                insert_node_helper(node.rightchild,value)
            end
        else
            return node
        end
    end

    # implemented with a queue
    def breadth_first_search(target)
        queue = Array.new
        queue.unshift(@root)

        while !queue.empty?

            element = queue.shift

            return element if element.value == target

            queue << element.leftchild if !element.leftchild.nil?
            queue << element.rightchild if !element.rightchild.nil?

        end

        return nil

    end

    #implemented with a stack
    def depth_first_search(target)
        stack = Array.new
        stack.push(@root)

        while !stack.empty?

            element = stack.pop

            return element if element.value == target

            stack.push(element.leftchild) if !element.leftchild.nil?
            stack.push(element.rightchild) if !element.rightchild.nil?

        end

        return nil
    end

    # method that runs a depth first search recursively
    def dfs_rec(target)
        dfs_recursive_helper(target,@root)
    end

    def dfs_recursive_helper(target, current_node)

        return nil if current_node.nil?
        return current_node if current_node.value == target
        left_node = dfs_recursive_helper(target, current_node.leftchild)
        return left_node if !left_node.nil?
        right_node = dfs_recursive_helper(target, current_node.rightchild)
        return right_node if !right_node.nil?

    end

    def tb_print(array)
        puts " "
        array.each {|i| puts "#{i} value #{i.value if !i.nil?} #{i.leftchild.value if !i.leftchild.nil?} #{i.rightchild.value if !i.rightchild.nil?}"}
    end
end


# tests:
# array_sorted = [16,14,10,8,7,9,3,2,4,1]
array_sorted = [28,22,32,38,21,11,26,36]
root = array_sorted[0]
btree = TreeBuilder.new(root)
btree_array = btree.build_tree(array_sorted)


btree.tb_print(btree_array)
puts btree.breadth_first_search(3)
puts btree.dfs_rec(8)

