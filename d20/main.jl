function parse_matrix(S)
    hcat([collect(row) .== '#' for row in S]...)'
end

function parse_input(input_file)
    open(input_file) do f
        lines = readlines(f)
        iea = collect(lines[1]) .== '#'
        A = parse_matrix(lines[3:end])
        iea, A
    end
end

function add_boarder(A::AbstractMatrix, k, type)
    n, m = size(A)
    f = type == true ? ones : zeros
    A = [f(Bool, n, k) A f(Bool, n, k)]
    A = [f(Bool, k, m + 2k); A; f(Bool, k, m + 2k)]
    A
end

function display_M(A)
    n, m = size(A)
    for i in 1:n
        for j in 1:m
            if A[i, j]
                print("#")
            else
                print(".")
            end
        end
        println()
    end
    println()
end

function calculate_bin(M::AbstractMatrix)
    b = [M[1, 1:end]; M[2, 1:end]; M[3, 1:end]]
    sum(2 .^ (8:-1:0) .* b)
end

function enchance(A, iea, type)
    A = add_boarder(A, 2, type)
    n, m = size(A)
    B = [calculate_bin(A[i-1:i+1, j-1:j+1]) for i in 2:n-1, j in 2:m-1]
    n, m = size(B)
    A = [iea[B[i, j]+1] for i in 1:n, j in 1:m]
    A
end

function solution_d20_1(input_file)
    iea, A = parse_input(input_file)
    # infinity observation makes true/false
    A = enchance(A, iea, false)
    A = enchance(A, iea, true)
    sum(A)
end


function solution_d20_2(input_file)
    iea, A = parse_input(input_file)
    for _ in 1:25
        A = enchance(A, iea, false)
        A = enchance(A, iea, true)
    end
    sum(A)
end

solution_d20_1("d20/input2.txt")
solution_d20_2("d20/input2.txt")
