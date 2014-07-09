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

    #Binary tree and array representation for the MaxHeap
    def build_tree_from_sorted2(array)
        j = 0
        arr = []

        array.each do |i|

            left  = 2 * j + 1
            right = 2 * j + 2
            parent = array[j]# ((j) / 2).floor
            value = array[j]

            # puts value
            tree = Node.new(i)

            if (left) < array.length then
                tree.leftchild = Node.new(array[left])
                # arr << tree.leftchild
            end

            if (right ) < array.length then
                tree.rightchild = Node.new(array[right])
                # arr << tree.rightchild
            end

            arr << tree

            j += 1

        end

        arr
    end


    def tb_print(array)
        puts " "
        # array.each {|i| puts "#{i.class} value: #{i.value} #{i.leftchild} #{i.rightchild}"}
        # array.each {|i| puts "\n#{i.class} value #{i.value} left_value: #{i.leftchild.value if !i.leftchild.nil?} right_value: #{i.rightchild.value if i.rightchild.nil?}\n"}
        array.each {|i| puts "#{i} value #{i.value if !i.nil?} #{i.leftchild.value if !i.leftchild.nil?} #{i.rightchild.value if !i.rightchild.nil?}"}
        # array.each {|i| puts "#{i.class} value #{i.value if !i.nil?}"}
        array.each_with_index do |i,index|
            if index > 0
                # puts "#{i} value #{i.value if !i.nil?} #{i.leftchild.value if !i.leftchild.nil?} #{i.rightchild.value if !i.rightchild.nil?}"
            end
        end
        puts array.length

    end
end

array_sorted = [16,14,10,8,7,9,3,2,4,1] #[10,20,30,40,50]
# arr2 = [100,40,60,50,20]
# puts "\n"
root = array_sorted[0]
tb = TreeBuilder.new(root)
node_arr = tb.build_tree(array_sorted)

tb.tb_print(node_arr)
puts tb.breadth_first_search(3).value

puts tb.dfs_rec(8).value

