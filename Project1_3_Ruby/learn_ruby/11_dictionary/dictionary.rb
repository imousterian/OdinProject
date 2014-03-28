class Dictionary

    def initialize
        @entries = {}
    end

    def entries
        @entries
    end

    def add (name=nil, value ="fish")
        if (entries.length == 0)
            entries[name] = value
        else
            entries = {}
            entries[name] = value
        end
    end


end