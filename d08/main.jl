
function solution_d8_1(input_file)
    lines = open(input_file) do f
        split.(readlines(f), " | ")
    end
    c = 0
    lengths = [2; 4; 3; 7]
    for (_, out) in lines
        for e in split(out)
            if length(e) in lengths
                c+=1
            end
        end
    end
    c
end

sorts(str) = join(sort(collect(str)))
merges(s1, s2) = unique(s1 * s2) |> collect |> sort |> join
unmerges(s1, s2) = setdiff(Set(s1), Set(s2)) |> collect |> sort |> join
soccursin(s1, s2) = issubset(Set(s1), Set(s2))
function detect1478(num::String, known::Dict{Int, String})
    if length(num) == 2
        res = 1
    elseif length(num) == 4
        res = 4
    elseif length(num) == 3
        res = 7
    elseif length(num) == 7
        res = 8
    else
        return known
    end
    known[res] = num
    return known
end

function detect6(num::String, known::Dict{Int, String})
    # @show num, unmerges(known[8], known[1])
    if soccursin(unmerges(known[8], known[1]), num)
        known[6] = num
    end
    return known
end

function detect0(num::String, known::Dict{Int, String})
    if soccursin(merges(unmerges(known[8], known[4]), known[1]), num)
        known[0] = num
    end
    return known
end

function detect5(num::String, known::Dict{Int, String})
    if soccursin(num, known[6])
        known[5] = num
    end
    return known
end

function detect9(num::String, known::Dict{Int, String})
    if num == merges(known[5], known[1])
        known[9] = num
    end
    return known
end

function detect2(num::String, known::Dict{Int, String})
    if length(unmerges(known[1], num)) == 1
        known[2] = num
    end
    return known
end

function detect3(num::String, known::Dict{Int, String})
    known[3] = num
    return known
end


function detect(nums::Vector{String})
    ndetected = 0
    known = Dict{Int, String}()

    for (i, fun) in enumerate((detect1478, detect6, detect0, detect5, detect9, detect2, detect3))
        while ndetected < 3 + i
            last = ""
            for num in nums
                last = num
                known = fun(num, known)
                if length(known) > ndetected
                    ndetected += 1
                    break
                end
            end
            if length(nums) == 0
                break
            end
            
            filter!(s->s!=last, nums)
        end
        
    end
    return known
end

function solution_d8_2(input_file)
    lines = open(input_file) do f
        split.(readlines(f), " | ")
    end
    c = 0
    for (inp, out) in lines
        inps = sorts.(split(inp))
        dnums = detect(inps)
        dout = Dict([v=>k for (k, v) in dnums])

        outs = sorts.(split(out))
        a = 1000 * dout[outs[1]] + 100 * dout[outs[2]] + 10 * dout[outs[3]] + dout[outs[4]]
        c += a
    end
    c
end

solution_d8_1("d8/input.txt")
solution_d8_1("d8/input2.txt")
solution_d8_2("d8/input.txt")
solution_d8_2("d8/input2.txt")
