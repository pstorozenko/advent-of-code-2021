
function solution_d5_1(input_file)
    input = open(input_file) do f
        readlines(f)
    end
    to_draw::Vector{Tuple{Tuple{Int, Int}, Tuple{Int, Int}}} = []
    max_x = max_y = 0
    
    for line in input
        from, to = split(line, " -> ")
        x1, y1 = parse.(Int, split(from, ","))
        x2, y2 = parse.(Int, split(to, ","))
    
        push!(to_draw, ((x1, y1), (x2, y2)))
        max_x = max(max_x, max(x1, x2))
        max_y = max(max_y, max(y1, y2))
    
    end
    M = zeros(Int, max_x+1, max_y+1)
    for ((x1, y1), (x2, y2)) in to_draw
        if x1 == x2 # vertical
            if y2 < y1
                y1, y2 = y2, y1
            end
            for y in y1:y2
                M[x1+1, y+1] += 1
            end
        elseif y1 == y2 # horizontal
            if x2 < x1
                x1, x2 = x2, x1
            end
            for x in x1:x2
                M[x+1, y1+1] += 1
            end
        end
        
    end
    sum(M .> 1)
end

function solution_d5_2(input_file)
    input = open(input_file) do f
        readlines(f)
    end
    to_draw::Vector{Tuple{Tuple{Int, Int}, Tuple{Int, Int}}} = []
    max_x = max_y = 0
    
    for line in input
        from, to = split(line, " -> ")
        x1, y1 = parse.(Int, split(from, ","))
        x2, y2 = parse.(Int, split(to, ","))
    
        push!(to_draw, ((x1, y1), (x2, y2)))
        max_x = max(max_x, max(x1, x2))
        max_y = max(max_y, max(y1, y2))
    
    end
    M = zeros(Int, max_x+1, max_y+1)
    for ((x1, y1), (x2, y2)) in to_draw
        xs = x1<x2 ? (x1:x2) : (x1:-1:x2)
        ys = y1<y2 ? (y1:y2) : (y1:-1:y2)
        ys = length(ys) == 1 ?  Iterators.cycle(ys) : ys
        xs = length(xs) == 1 ?  Iterators.cycle(xs) : xs
        for (x, y) in zip(xs, ys)
            M[x+1, y+1] += 1
        end
    end
    sum(M .> 1)
end

solution_d5_1("d5/input.txt")
solution_d5_1("d5/input2.txt")
solution_d5_2("d5/input.txt")
solution_d5_2("d5/input2.txt")
