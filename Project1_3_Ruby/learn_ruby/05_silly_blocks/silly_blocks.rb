# by Marina Drigo

def reverser

    yield.split(' ').each { |item| item.reverse! }.join(' ')

end

def adder (number = 1)
    yield + number
end

def repeater (number = 1)
    number.times do
        yield
    end
end