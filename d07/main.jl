using Statistics
function solution_d7_1(input_file)
    x = open(input_file) do f
        parse.(Int, split(readlines(f)[1], ","))
    end
    m = median(x)
    sum(abs.(x .- m))
end

function dist(x, m)
    d = abs(x - m)
    d * (d+1) / 2
end

function solution_d7_2(input_file)
    x = open(input_file) do f
        parse.(Int, split(readlines(f)[1], ","))
    end
    m = round(mean(x))
    cost(m, x) = sum(Int, dist.(x, m))
    min(cost(m, x), cost(m-1, x))
end

solution_d7_1("d7/input.txt")
solution_d7_1("d7/input2.txt")
solution_d7_2("d7/input.txt")
solution_d7_2("d7/input2.txt")
