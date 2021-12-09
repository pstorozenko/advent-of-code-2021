function parse_matrix(S)
    hcat([parse.(Int, split(row)) for row in S]...)'
end

function solution_d4_1(input_file)
    input = open(input_file) do f
        readlines(f)
    end
    samples = parse.(Int, split(input[1], ","))
    n = (length(input) - 1) ÷ 6
    boards::Vector{Matrix{Int}} = []
    for i in 0:n-1
        board = parse_matrix(input[6i + 3 : 6i + 7])
        push!(boards, board)
    end
    rows = zeros(Int, (n, 5))
    cols = zeros(Int, (n, 5))
    masks = [zeros(Bool, 5, 5) for _ in 1:n]
    for s in samples, (i, board) in enumerate(boards)
        idx = findfirst(x->x==s, board)
        if !isnothing(idx)
            rows[i, idx[1]] += 1
            cols[i, idx[2]] += 1
            masks[i][idx] = true
            if rows[i, idx[1]] == 5 || cols[i, idx[2]] == 5
                return s * sum(board[ .! masks[i]])
            end
        end
    end
    "Error"
end

function solution_d4_2(input_file)
    input = open(input_file) do f
        readlines(f)
    end
    samples = parse.(Int, split(input[1], ","))
    n = (length(input) - 1) ÷ 6
    boards::Vector{Matrix{Int}} = []
    for i in 0:n-1
        board = parse_matrix(input[6i + 3 : 6i + 7])
        push!(boards, board)
    end
    rows = zeros(Int, (n, 5))
    cols = zeros(Int, (n, 5))
    masks = [zeros(Bool, 5, 5) for _ in 1:n]
    won = zeros(Bool, n)
    num_won = 0
    for s in samples, (i, board) in enumerate(boards)
        if won[i]
            continue
        end
        idx = findfirst(x->x==s, board)
        if !isnothing(idx)
            rows[i, idx[1]] += 1
            cols[i, idx[2]] += 1
            masks[i][idx] = true
            if rows[i, idx[1]] == 5 || cols[i, idx[2]] == 5
                won[i] = true
                num_won += 1
                if num_won == n
                    return s * sum(board[ .! masks[i]])
                end
            end
        end
    end
    "Error"
end

solution_d4_1("d4/input.txt")
solution_d4_1("d4/input2.txt")
solution_d4_2("d4/input.txt")
solution_d4_2("d4/input2.txt")
