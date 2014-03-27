class Timer

    attr_accessor :seconds

    def initialize
        @seconds = 0
    end

    def time_string
        currentHour = @seconds / 3600

        currentMinute = (@seconds % 3600) / 60

        currentSecond = "f" (@seconds % 3600) % 60

        return "%02d:%02d:%02d" % [currentHour, currentMinute, currentSecond]
    end

end