# by Marina Drigo

def measure (count = 1)

    time = 0

    count.times do

        beginning = Time.now

        yield

        ends = Time.now

        time += (ends - beginning)

    end

    return time / count

end