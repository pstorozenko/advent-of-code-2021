using DataStructures

function parse_input(input_file)
    open(input_file) do f
        input = readlines(f)
        S = input[1]
        D = Dict{String,Tuple{String,String}}()
        for line in input[3:end]
            pat, rep = split(line, " -> ")
            D[pat] = (pat[1] * rep, rep * pat[2])
        end
        S, D
    end
end


function step(H, D)
    H2 = DefaultDict{String,Int128}(0)
    for (k, v) in H
        p1, p2 = D[k]
        H2[p1] += v
        H2[p2] += v
    end
    H2
end

function mcount(H, S)
    d = DefaultDict{Char,Int128}(0)
    d[S[1]] += 1
    d[S[end]] += 1
    for (s, v) in H
        d[s[1]] += v
        d[s[2]] += v
    end
    Dict([k => v ÷ 2 for (k, v) in d])
end

function solution_d14(input_file, t_max)
    S, D = parse_input(input_file)

    H = DefaultDict{String,Int128}(0)
    for i = 1:length(S)-1
        H[S[i:i+1]] += 1
    end

    for t = 1:t_max
        H = step(H, D)
    end
    cnt = mcount(H, S)
    maximum(values(cnt)) - minimum(values(cnt))
end

# solution_d14("d14/input.txt", 10)
# solution_d14("d14/input2.txt", 10)
# solution_d14("d14/input.txt", 40)
# solution_d14("d14/input2.txt", 40)
