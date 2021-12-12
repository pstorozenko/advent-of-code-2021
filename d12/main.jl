using DataStructures

@enum CaveSize small big

struct Cave
    size::CaveSize
    lab::String
    function Cave(label)
        if uppercase(label) == label
            new(big, label)
        else
            new(small, label)
        end
    end
end

isbig(c::Cave) = c.size == big

function create_graph(input)
    d = DefaultDict{Cave,Set{Cave}}(Set{Cave})
    for line in input
        (from, to) = split(line, "-")
        cf = Cave(from)
        ct = Cave(to)
        push!(d[cf], ct)
        push!(d[ct], cf)
    end
    d
end

function crawl(G, visited, path)
    vl = path[end]
    if vl == Cave("end")
        return [path]
    end
    paths = Vector{Vector{Cave}}()
    for v in G[vl]
        if isbig(v) || !(v in visited)
            path_c = copy(path)
            visited_c = copy(visited)
            push!(path_c, v)
            push!(visited_c, v)
            n_paths = crawl(G, visited_c, path_c)
            append!(paths, n_paths)
        end
    end
    paths
end

function solution_d12_1(input_file)
    G = open(input_file) do f
        create_graph(readlines(f))
    end
    sc = Cave("start")
    paths = crawl(G, Set([sc]), [sc])
    length(paths)
end

function crawl2(G, visited, path, visited_twice)
    vl = path[end]
    if vl == Cave("end")
        return [path]
    end
    paths = Vector{Vector{Cave}}()
    for v in G[vl]
        if isbig(v) || !(v in visited)
            path_c = copy(path)
            visited_c = copy(visited)
            push!(path_c, v)
            push!(visited_c, v)
            n_paths = crawl2(G, visited_c, path_c, visited_twice)
            append!(paths, n_paths)

            if !visited_twice && !isbig(v)
                path_c = copy(path)
                visited_c = copy(visited)
                push!(path_c, v)
                n_paths2 = crawl2(G, visited_c, path_c, true)
                append!(paths, n_paths2)
            end
        end
    end
    unique(paths)
end

function solution_d12_2(input_file)
    G = open(input_file) do f
        create_graph(readlines(f))
    end
    sc = Cave("start")
    paths = crawl2(G, Set([sc]), [sc], false)
    length(paths)
end

solution_d12_1("d12/input.txt")
solution_d12_1("d12/input2.txt")
solution_d12_2("d12/input.txt")
solution_d12_2("d12/input2.txt")
