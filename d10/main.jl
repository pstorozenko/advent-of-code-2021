using DataStructures

matching1 = Dict([
    '<' => '>',
    '(' => ')',
    '[' => ']',
    '{' => '}'
])
matching2 = Dict([
    '>' => '<',
    ')' => '(',
    ']' => '[',
    '}' => '{',
])

function solution_d10_1(input_file)
    input = open(input_file) do f
       readlines(f)
    end
    dc = Dict{Char, Int}([')' => 3, ']' => 57, '}' => 1197, '>'=> 25137])
    cost = 0
    for line in input
        bs = Stack{Char}()
        for c in line
            if c in ('<', '(', '[', '{')
                push!(bs, c)
            elseif c in ('}', ']', ')', '>')
                top = pop!(bs)
                if top != matching2[c]
                    cost += dc[c]
                end
            end
        end
    end
    cost
end

function line_correctness(line)
    bs = Stack{Char}()
    for c in line
        if c in ('<', '(', '[', '{')
            push!(bs, c)
        elseif c in ('}', ']', ')', '>')
            top = pop!(bs)
            if top != matching2[c]
                return false, missing
            end
        end
    end
    return true, bs
end

function solution_d10_2(input_file)
    input = open(input_file) do f
       readlines(f)
    end
    dc = Dict{Char, Int}([')' => 1, ']' => 2, '}' => 3, '>'=> 4])
    scores = Vector{Int}()
    for line in input
        success, bs = line_correctness(line)
        if success
            lc = 0
            for c in collect(bs)
                lc = lc * 5 + dc[matching1[c]]
            end
            push!(scores, lc)
        end
    end
    sort!(scores)
    n = length(scores)
    scores[trunc(Int, (n+1)/2)]
end

solution_d10_1("d10/input.txt")
solution_d10_1("d10/input2.txt")
solution_d10_2("d10/input.txt")
solution_d10_2("d10/input2.txt")
