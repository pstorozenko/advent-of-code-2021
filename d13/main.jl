function read_input(input_file)
    P, F = open(input_file) do f
        S = readlines(f)
        f = true
        P = Vector{Tuple{Int, Int}}()
        F = Vector{Tuple{String, Int}}()
        for line in S
            if line == ""
                f = false
                continue
            end

            if f
                push!(P, tuple(parse.(Int, split(line, ","))...))
            else
                w, v = split(line[12:end], "=")
                push!(F, (w, parse(Int, v)))
            end
        end
        P, F
    end
end

function fold_paper(P, w, v)
    R = if w == "x"
        map(P) do (px, py)
            if px > v
                px = v - (px - v)
            end
            px, py
        end
    else
        map(P) do (px, py)
            if py > v
                py = v - (py - v)
            end
            px, py
        end
    end
    unique(R)
end

function printP(P)
    mi_x, ma_x = 99999, 0
    mi_y, ma_y = 99999, 0
    for (x, y) in P
        mi_x = min(mi_x, x)
        ma_x = max(ma_x, x)
        mi_y = min(mi_y, y)
        ma_y = max(ma_y, y)
    end
    A = zeros(Int, ma_x+1, ma_y+1)
    for (x, y) in P
        A[x+1, y+1] = 1
    end
    A = A'
    for i in 1:ma_y+1
        for j in 1:ma_x+1
            if A[i, j] == 1
                print("█")
            else
                print(" ")
            end
        end
        println()
    end
end


function solution_d13_1(input_file)
    P, F = read_input(input_file)
    w, v = F[1]
    P = fold_paper(P, w, v)
    length(P)
end

function solution_d13_2(input_file)
    P, F = read_input(input_file)
    w, v = F[1]
    for (w, v) in F
        P = fold_paper(P, w, v)
    end
    printP(P)
end


solution_d13_1("d13/input.txt")
solution_d13_1("d13/input2.txt")
solution_d13_2("d13/input.txt")
solution_d13_2("d13/input2.txt")
