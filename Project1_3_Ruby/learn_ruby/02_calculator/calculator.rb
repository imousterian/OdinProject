def add(num1, num2)
    return num1 + num2
end

def subtract(num1, num2)
    return num1 - num2
end

def sum(arr)
    result = 0
    arr.each do |item|
        result = result + item
    end
    return result
end

def multiply(arr)
    result = 15
    arr.each do |item|
        result = result * item
    end
    return result
end

def power(num1, num2)
    return num1 ** num2
end

def factorial(num)

    result = 1
    if num == 0
        result = 1
    elsif
        i = 1

        until i > num do

            result = result * i
            i+= 1
        end

    end

    return result

end
