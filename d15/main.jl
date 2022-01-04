using DataStructures

function parse_matrix(S)
    hcat([parse.(Int, collect(row)) for row in S]...)'
end

function read_input(input_file)
    A = open(input_file) do f
        parse_matrix(readlines(f))
    end
end

INF = 9999999

function get_neighbors(ui, uj, n, m)
    if 1 < ui < n && 1 < uj < m
        [(ui-1, uj), (ui, uj-1), (ui+1, uj), (ui, uj+1)]
    elseif ui == 1 && uj == 1
        [(ui, uj+1), (ui+1, uj)]
    elseif ui == n && uj == m
        [(ui, uj-1), (ui-1, uj)]
    elseif ui == n && uj == 1
        [(ui-1, uj), (ui, uj+1)]
    elseif ui == 1 && uj == m
        [(ui+1, uj), (ui, uj-1)]
    elseif ui == 1
        [(ui+1, uj), (ui, uj-1), (ui, uj+1)]
    elseif ui == n
        [(ui-1, uj), (ui, uj-1), (ui, uj+1)]
    elseif uj == 1
        [(ui-1, uj), (ui+1, uj), (ui, uj+1)]
    elseif uj == m
        [(ui-1, uj), (ui+1, uj), (ui, uj-1)]
    else
        @show ui, uj, n, m
    end
end

function solution_d15_1(input_file)
    A = read_input(input_file)
    
    
    B = [A;A.+1;A.+2;A.+3;A.+4]
    A = [B B.+1 B.+2 B.+3 B.+4]
    while any(A .> 9)
        A[A .> 9] .= A[A .> 9] .- 9 
    end
    n, m = size(A)
    d = zeros(Int, (n, m)) .+ INF
    d[1] = 0 
    prev = Array{Tuple{Int, Int}}(undef, (n,m))
    
    Q = PriorityQueue{Tuple{Int, Int}, Int}()
    for i in 1:n, j in 1:m
        enqueue!(Q, (i, j), d[i, j])
    end
    while !isempty(Q)
        ui, uj = dequeue!(Q)
        for (ni, nj) in get_neighbors(ui, uj, n, m)
            if d[ui, uj] + A[ni, nj] < d[ni, nj]
                d[ni, nj] = d[ui, uj] + A[ni, nj]
                Q[(ni, nj)] = d[ni, nj]
                prev[ni, nj] = (ui, uj)
            end
        end
    end
    d[end, end]
end



# solution_d15_1("d15/input.txt")
solution_d15_1("d15/input2.txt")
# solution_d15_2("d15/input.txt")
# solution_d15_2("d15/input2.txt")