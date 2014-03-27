#by Marina Drigo

class Temperature

    attr_accessor :in_fahrenheit, :in_celsius

    # constructor
    def initialize (options)

        if (options[:f])
            @in_fahrenheit = options[:f]
            @in_celsius = (options[:f] - 32.0) * 5.0 / 9.0
        else
            @in_celsius = options[:c]
            @in_fahrenheit = (options[:c] * 9.0 / 5.0 ) + 32.0
        end

    end

    # factor methods
    def self.from_celsius degrees_celsius
        new(:c => degrees_celsius)
    end

    def self.from_fahrenheit degrees_fahrenheit
        new(:f => degrees_fahrenheit)
    end

end


#subclasses
class Celsius < Temperature
    # subclass calls a superclass method
    def initialize(c)
        super(:c => c)
    end
end

class Fahrenheit < Temperature
    def initialize(f)
        super(:f => f)
    end
end