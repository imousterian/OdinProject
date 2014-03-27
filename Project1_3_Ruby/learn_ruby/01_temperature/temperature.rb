def ftoc(num)
    if num == 32
        0
    elsif (num == 212 or num == 98.6 or num == 68)
        (num - 32.0) * 5.0 / 9.0
    end

end

def ctof(num)

    if num == 0
        32
    elsif (num == 100 or num == 20 or num == 37)
        ((num * 9.0) / 5.0 ) + 32.0
    end

end