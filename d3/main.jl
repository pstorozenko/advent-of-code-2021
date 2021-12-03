function row2number(row)
    v = row[1, :]
    s = 0
    n = length(v)
    for i in 1:n
        s += 2^(i - 1) * v[n - i + 1]
    end
    s
end

function solution_d3_1(input_file)
    s = open(input_file) do f
        split.(readlines(f), "")
    end
    b = hcat([parse.(Int, row) for row in s]...)'
    nrow = size(b,1)
    gamma_rate = sum(b, dims=1) .> nrow/2
    epsilon_rate = (-gamma_rate) .+ 1
    row2number(epsilon_rate) * row2number(gamma_rate)
end

function get_oxygen_rate(b)
    n = size(b, 1)
    r = copy(b)
    for i in 1:n
        an = size(r, 1)
        if an == 1
            break
        end
        s = sum(r[:, i])
        q = s >= an/2
        r = r[r[:, i] .== q, :]
    end
    row2number(r)
end

function get_CO2_srubber_rate(b)
    n = size(b, 1)
    r = copy(b)
    for i in 1:n
        an = size(r, 1)
        if an == 1
            break
        end
        s = sum(r[:, i])
        q = s < an/2
        r = r[r[:, i] .== q, :]
    end
    row2number(r)
end

function solution_d3_2(input_file)
    st = open(input_file) do f
        split.(readlines(f), "")
    end
    b = hcat([parse.(Int, row) for row in st]...)'
    oxygen_rate = get_oxygen_rate(b)
    CO2_srubber_rate = get_CO2_srubber_rate(b)
    oxygen_rate * CO2_srubber_rate
end

solution_d3_1("d3/input.txt")
solution_d3_1("d3/input2.txt")
solution_d3_2("d3/input.txt")
solution_d3_2("d3/input2.txt")
