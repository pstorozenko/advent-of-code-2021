using DataStructures

function parse_matrix(S)
    hcat([parse.(Int, collect(row)) for row in S]...)'
end

function solution_d9_1(input_file)
    A = open(input_file) do f
        parse_matrix(readlines(f))
    end
    n, m = size(A)
    A = [(zeros(Int, m).+9)'; A; (zeros(Int, m).+9)']
    A = [(zeros(Int, n+2).+9) A (zeros(Int, n+2).+9)]
    n, m = size(A)
    sr = 0
    for i in 2:n-1, j in 2:m-1
        if (A[i, j] < A[i, j+1] &&
            A[i, j] < A[i+1, j] &&
            A[i, j] < A[i-1, j] &&
            A[i, j] < A[i, j-1])
            sr += A[i, j] + 1
        end
    end
    sr
end

function solution_d9_2(input_file)
    A = open(input_file) do f
        parse_matrix(readlines(f))
    end
    n, m = size(A)
    A = [(zeros(Int, m).+9)'; A; (zeros(Int, m).+9)']
    A = [(zeros(Int, n+2).+9) A (zeros(Int, n+2).+9)]
    n, m = size(A)
    B = A .< 9
    C = zeros(Int, n, m)
    c = 1
    for i in 2:n-1, j in 2:m-1
        if B[i, j] && C[i, j] == 0
            q = Queue{Tuple{Int, Int}}()
            enqueue!(q, (i, j))
            while !isempty(q)
                i, j = dequeue!(q)
                C[i, j] = c
                B[i, j+1] && C[i, j+1] == 0 && enqueue!(q, (i, j+1))
                B[i+1, j] && C[i+1, j] == 0 && enqueue!(q, (i+1, j))
                B[i, j-1] && C[i, j-1] == 0 && enqueue!(q, (i, j-1))
                B[i-1, j] && C[i-1, j] == 0 && enqueue!(q, (i-1, j))
            end
            c += 1
        end
    end
    sizes = map(1:c) do x
        sum(C .== x)
    end
    sort!(sizes, rev=true)
    prod(sizes[1:3])
end

solution_d9_1("d9/input.txt")
solution_d9_1("d9/input2.txt")
solution_d9_2("d9/input.txt")
solution_d9_2("d9/input2.txt")
