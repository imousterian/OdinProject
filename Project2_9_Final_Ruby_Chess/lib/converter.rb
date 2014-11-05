module Converter

    def Converter.rows
        return 8
    end

    def Converter.cols
        return 8
    end

    def Converter.convert_x_y_to_location(x,y)
        x * rows + y + 1
    end

    def Converter.convert_location_to_x_y(loc)
        (0...rows).each do |i|
            (0...cols).each do |j|
                return i, j if loc == convert_x_y_to_location(i,j).to_s
            end
        end
        nil
    end
end
