using SparseArrays

@enum Opp OFF ON
struct Operation
    op::Opp
    xr::UnitRange
    yr::UnitRange
    zr::UnitRange
end
function parse_input(input_file)
    reg = r"(\w+) x=(-?\d+)\.\.(-?\d+),y=(-?\d+)\.\.(-?\d+),z=(-?\d+)\.\.(-?\d+)"

    open(input_file) do f
        map(readlines(f)) do line
            m = collect(match(reg, line))
            ms = parse.(Int, m[2:7])
            Operation(
                m[1] == "on" ? ON : OFF,
                ms[1]:ms[2],
                ms[3]:ms[4],
                ms[5]:ms[6]
            )
        end
    end
end

function process_ops(ops)
    map(ops) do op
        Operation(
            op.op,
            (op.xr) .+ 51,
            (op.yr) .+ 51,
            (op.zr) .+ 51
        )
    end
end

function solution_d22_1(input_file)
    ops = parse_input(input_file)
    ops = process_ops(ops)
    A = zeros(Int, (101, 101, 101))
    for op in ops
        A[op.xr, op.yr, op.zr] .= op.op == ON ? 1 : 0 
    end
    sum(A)
end

# solution_d22_1("d22/input.txt")
solution_d22_1("d22/input2.txt")