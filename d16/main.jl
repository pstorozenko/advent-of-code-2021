function parse_input(input_file)
    open(input_file) do f
        line = readlines(f)[1]
        symbols = map(collect(line)) do c
            h = parse(Int8, c, base = 16)
            bitstring(h)[5:end]
        end
        prod(symbols)
    end
end
function parse_packet(p)
    v = p[1:3]
    vi = parse(Int, v, base = 2)
    id = p[4:6]
    if id == "100" # literal
        k = 7
        res = ""
        while p[k] == '1'
            res *= p[k+1:k+4]
            k += 5
        end
        res *= p[k+1:k+4]
        return parse(Int, res, base = 2), p[k+5:end], vi
    else # operator
        lengh_type = p[7]
        if lengh_type == '0'
            l = parse(Int, p[8:8+14], base = 2)
            subpackets = p[8+15:8+15+l-1]

            rest = subpackets
            vs = 0
            while rest != ""
                _, rest, vk = parse_packet(rest)
                vs += vk
            end
            return -1, p[8+15+l:end], vi + vs
        else
            n = parse(Int, p[8:8+10], base = 2)
            rest = p[8+11:end]
            vs = 0
            for i = 1:n
                _, rest, vk = parse_packet(rest)
                vs += vk
            end
            return -1, rest, vi + vs
        end
    end
end

function solution_d16_1(input_file)
    S = parse_input(input_file)
    parse_packet(S)
end

function greater_than(iter)
    Int(iter[1] > iter[2])
end

function less_than(iter)
    Int(iter[1] < iter[2])
end

function equal_to(iter)
    Int(iter[1] == iter[2])
end

operations = (
    sum,
    prod,
    minimum,
    maximum,
    missing,
    greater_than,
    less_than,
    equal_to
)

function parse_packet2(p)
    v = p[1:3]
    vi = parse(Int, v, base = 2)
    id = p[4:6]
    idi = parse(Int, id, base = 2)
    if id == "100" # literal
        k = 7
        res = ""
        while p[k] == '1'
            res *= p[k+1:k+4]
            k += 5
        end
        res *= p[k+1:k+4]
        return parse(Int, res, base = 2), p[k+5:end], vi
    else # operator
        lengh_type = p[7]
        subpackets = Int[]
        op = operations[idi+1]
        if lengh_type == '0'
            l = parse(Int, p[8:8+14], base = 2)
            rest_s = p[8+15:8+15+l-1]
            vs = 0

            while rest_s != ""
                val, rest_s, vk = parse_packet(rest_s)
                push!(subpackets, val)
                vs += vk
            end
            return op(subpackets), p[8+15+l:end], vi + vs
        else
            n = parse(Int, p[8:8+10], base = 2)
            rest = p[8+11:end]
            vs = 0
            for i = 1:n
                val, rest, vk = parse_packet(rest)
                push!(subpackets, val)
                vs += vk
            end
            return op(subpackets), rest, vi + vs
        end
    end
end

function solution_d16_2(input_file)
    S = parse_input(input_file)
    parse_packet2(S)
end

# solution_d16_1("d16/input.txt")
# solution_d16_1("d16/input2.txt")
# solution_d16_2("d16/input.txt")
solution_d16_2("d16/input2.txt")
# 20124344