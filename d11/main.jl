function parse_matrix(S)
    hcat([parse.(Int, collect(row)) for row in S]...)'
end

function add_boarders(A, k)
    n, m = size(A)
    A = [(zeros(Int, m) .+ k)'; A; (zeros(Int, m) .+ k)']
    A = [(zeros(Int, n + 2) .+ k) A (zeros(Int, n + 2) .+ k)]
end

function simulate(A, t_max)
    c = 0
    A = add_boarders(A, -99999)
    n, m = size(A)
    for t = 1:t_max
        F = zeros(Bool, n, m)
        A .+= 1
        idxs = findall(A .> 9)
        # @show idxs
        while length(idxs) > 0
            F[idxs] .= true
            # @show F
            for idx in idxs
                i, j = idx.I
                A[idx] = 0
                A[i-1:i+1, j-1:j+1] .+= 1
                c += 1
            end
            A[F] .= 0
            idxs = findall(A .> 9)
        end
    end
    c
end

function solution_d11_1(input_file)
    A = open(input_file) do f
        parse_matrix(readlines(f))
    end
    simulate(A, 100)

end

function simulate2(A)
    A = add_boarders(A, -9999999)
    n, m = size(A)
    t = 1
    while true
        F = zeros(Bool, n, m)
        A .+= 1
        idxs = findall(A .> 9)
        while length(idxs) > 0
            F[idxs] .= true
            for idx in idxs
                i, j = idx.I
                A[idx] = 0
                A[i-1:i+1, j-1:j+1] .+= 1
            end
            A[F] .= 0
            idxs = findall(A .> 9)
        end
        if sum(F) == (n - 2) * (m - 2)
            break
        end
        t += 1
    end
    t
end

function solution_d11_2(input_file)
    A = open(input_file) do f
        parse_matrix(readlines(f))
    end
    simulate2(A)

end

solution_d11_1("d11/input.txt")
solution_d11_1("d11/input2.txt")
solution_d11_2("d11/input.txt")
solution_d11_2("d11/input2.txt")
