class Location

    attr_accessor :x, :y

    def initialize(x,y)
        @x = x; @y = y
    end

    def valid?(num)
        valid_index?(@x, num) and valid_index?(@y, num)
    end

    def valid_index?(index, num)
        index >= 0 and index < num
    end

    def get_self(i,j)
        self if self.x == i and self.y == j
    end

end

class Knight

    def initialize(n)
        @path = Hash.new
        @visited_cells = Array.new (n) { |i| Array.new(n) { |j| false } }
        @nodes = Array.new
        @n = n
    end

    def set_source(location)
        @source_x, @source_y = location
    end

    def set_destination(location)
        @destination_x, @destination_y  = location
    end

    def determine_path

        beginning = Location.new(@destination_x, @destination_y)

        @nodes.push(beginning)

        while !@nodes.empty?

            current_node = @nodes.shift

            return current_node if current_node.x == @source_x and current_node.y == @source_y

            determine_neighbors_of(current_node)

        end
    end

    def determine_neighbors_of(current_node)

        add_neighbor_node(current_node, current_node)

        neighbor_node = Location.new(current_node.x - 2, current_node.y - 1)
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x - 2, current_node.y + 1)
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x - 1, current_node.y - 2) #
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x - 1, current_node.y + 2) #
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x + 1, current_node.y - 2) #
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x + 1, current_node.y + 2) #
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x + 2, current_node.y - 1) #
        add_neighbor_node(current_node,neighbor_node)

        neighbor_node = Location.new(current_node.x + 2, current_node.y + 1) #
        add_neighbor_node(current_node,neighbor_node)

    end

    def add_neighbor_node(current_node, neighbor_node)
        if neighbor_node.valid?(@n) and !@visited_cells[neighbor_node.x][neighbor_node.y]
            @visited_cells[neighbor_node.x][neighbor_node.y] = true
            @nodes.push(neighbor_node)
            @path[neighbor_node] = current_node
        end
    end

    def find_match_in_path(i,j)
        @path.each do |key, value|
            return key if key.x == i and key.y == j
        end
    end

    def print_path

        current_move = find_match_in_path(@source_x, @source_y)

        total_moves = 0

        final_path = Array.new

        while @path.has_key?(current_move)

            final_path.push([current_move.x, current_move.y])

            total_moves += 1

            if current_move.x == @path[current_move].x and current_move.y == @path[current_move].y then
                break
            else
                current_move = @path[current_move]
            end
        end

        puts "You made #{total_moves} moves. Your path is:"
        print final_path
        puts " "

    end

    def output_results(source, destination)

        set_source(source)

        set_destination(destination)

        determine_path

        print_path

    end

end


# tests

board_size  =  8
source      = [0,0]
destination = [3,3]

knight = Knight.new(board_size)

knight.output_results(source, destination)

# results: =>
# You made 3 moves. Your path is:
# [[0, 0], [1, 2], [3, 3]]






