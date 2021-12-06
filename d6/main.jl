using DataStructures 

function simulate(n, tmax)
    l = [n]
    for t in 1:tmax
        nl::Vector{Int} = []
        for i in 1:length(l)
            if l[i] == 0
                push!(nl, 8)
                l[i] = 6
            else
                l[i] -= 1
            end
        end
        append!(l, nl)
        @show l
    end
    length(l)
end

function solution_d6_1(input_file)
    input = open(input_file) do f
        parse.(Int, split(readlines(f)[1], ","))
    end
    s = 0
    for e in input
        s += simulate(e, 80)
    end
    s
end

function simulate2(n, tmax)
    l = [n]
    for t in 1:tmax
        nl::Vector{Int} = []
        for i in 1:length(l)
            if l[i] == 0
                push!(nl, 8)
                l[i] = 6
            else
                l[i] -= 1
            end
        end
        append!(l, nl)
    end
    l
end

function solution_d6_2(input_file)
    input = open(input_file) do f
        parse.(Int, split(readlines(f)[1], ","))
    end
    d = DefaultDict{Int, Int}(0)
    for e in input
        d[e] += 1
    end

    for _ in 1:8
        nd = DefaultDict{Int, Int}(0)
        for (k, v) in d
            l = simulate2(k, 32)
            for e in l
                nd[e] += v
            end
        end
        d = nd
    end
    sum(values(d))
end

solution_d6_1("d6/input.txt")
solution_d6_1("d6/input2.txt")
solution_d6_2("d6/input.txt")
solution_d6_2("d6/input2.txt")
