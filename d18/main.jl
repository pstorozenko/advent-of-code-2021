import Base.repr, Base.+, Base.show
using Printf, JSON3

mutable struct SNum
    left::Union{SNum, Int}
    right::Union{SNum, Int}
    SNum(l::Union{SNum, Int}, r::Union{SNum, Int}) = new(l, r)
    parse(e::Int) = e
    parse(e::JSON3.Array) = SNum(parse(e[1]), parse(e[2]))
    
    function SNum(s::String)
        A = JSON3.read(s)
        parse(A)
    end
end
repr(n::SNum) = "[$(repr(n.left)),$(repr(n.right))]" 
Base.show(io::IO, ::MIME"text/plain", n::SNum) = @printf(io, "%s", repr(n))

function add_right!(n::SNum, to_add)
    if n.right isa Int
        n.right += to_add
    else
        t = n.right
        while !(t.left isa Int)
            t = t.left
        end
        t.left += to_add
    end
end

function add_left!(n::SNum, to_add)
    if n.left isa Int
        n.left += to_add
    else
        t = n.left
        while !(t.right isa Int)
            t = t.right
        end
        t.right += to_add
    end
end

function _explode!(n::Int, k)
    false, false, (-1, -1)
end

function _explode!(n::SNum, k)
    if k > 4
        return true, true, (n.left, n.right)
    end

    s, je, (tl ,tr) = _explode!(n.left, k+1) # je -- just exploded
    
    
    if s
        add_right!(n, tr)
        if je
            n.left = 0
        end
        
        return true, false, (tl, 0)
    end

    s, je, (tl ,tr) = _explode!(n.right, k+1)
    if s
        add_left!(n, tl)
        if je
            n.right = 0
        end
        
        return true, false, (0, tr)
    end
    return false, false, (-1, -1)
end

function explode!(n::SNum)
    s, _, _ = _explode!(n, 1)
    return s
end

split!(_::Int) = return false

function split!(n::SNum)
    if n.left isa Int && n.left > 9
        k = n.left
        n.left = SNum(div(k, 2, RoundDown), div(k, 2, RoundUp))
        return true
    elseif n.right isa Int && n.right > 9
        k = n.right
        n.right = SNum(div(k, 2, RoundDown), div(k, 2, RoundUp))
        return true
    end
    return split!(n.left) || split!(n.right)
end

function mreduce(n::SNum)
    while explode!(n) || split!(n)
    end
    return n
end

magnitude(n::Int) = n
function magnitude(n::SNum)
    return 3*magnitude(n.left) + 2*magnitude(n.right)
end


+(l::SNum, r::Union{SNum, Int}) = mreduce(SNum(l, r))
+(l::Union{SNum, Int}, r::SNum) = mreduce(SNum(l, r))
+(l::SNum, r::SNum) = mreduce(SNum(l, r))


function parse_input(input_file)
    open(input_file) do f
        SNum.(readlines(f))
    end
end

function solution_d18_1(input_file)
    nums = parse_input(input_file)
    magnitude(foldl(+, nums))
end

function parse_input2(input_file)
    open(input_file) do f
        readlines(f)
    end
end

function solution_d18_2(input_file)
    nums = parse_input2(input_file)
    mm = 0
    for s1 in nums, s2 in nums
        if s1 == s2
            continue
        end
        n11 = SNum(s1)
        n12 = SNum(s1)
        n21 = SNum(s2)
        n22 = SNum(s2)
        
        mm = max(mm, magnitude(n11 + n21), magnitude(n22 + n12))
    end
    mm
end

solution_d18_1("d18/input.txt")
solution_d18_1("d18/input2.txt")
solution_d18_2("d18/input.txt")
solution_d18_2("d18/input2.txt")
