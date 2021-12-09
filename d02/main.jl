
function solution_d2_1(input_file)
    s = open(input_file) do f
        split.(readlines(f), " ")
    end
    h = d = 0
    for (dir, v) in s
        vi = parse(Int, v)
        if dir == "forward"
            h += vi
        elseif dir == "down"
            d += vi
        elseif dir == "up"
            d -= vi
        end
    end
    h * d
end


function solution_d2_2(input_file)
    s = open(input_file) do f
        split.(readlines(f), " ")
    end
    h = d = 0
    aim = 0
    for (dir, v) in s
        vi = parse(Int, v)
        if dir == "forward"
            h += vi
            d += aim * vi
        elseif dir == "down"
            # d += vi
            aim += vi
        elseif dir == "up"
            # d -= vi
            aim -= vi
        end
    end
    h * d
end

solution_d2_1("d2/input.txt")
solution_d2_1("d2/input2.txt")
solution_d2_2("d2/input.txt")
solution_d2_2("d2/input2.txt")
