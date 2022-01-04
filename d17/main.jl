function parse_input(input_file)
    S = readlines(input_file)[1]
    S = S[findfirst("x=", S).stop+1:end]
    x, y = split(S, ", y=")
    [parse.(Int, split(e, "..")) for e in (x, y)]
end

function simulate(vx0, vy0, xs, xe, ys, ye)
    x = 0
    y = 0
    vx = vx0
    vy = vy0
    t = 1
    y_max = 0
    is_success = false
    while y > ys - 1
        if xs <= x <= xe && ys <= y <= ye
            is_success = true
            break
        end
        y_max = max(y, y_max)
        x += vx
        y += vy
        vx += -sign(vx)
        vy += -1
        t += 1
    end
    return is_success, y_max, t
end

function solution_d17_1(input_file)
    (xs, xe), (ys, ye) = parse_input(input_file)
    y_max_total = -99999999
    for vx = 1:200, vy = 1:2000
        is_success, y_max = simulate(vx, vy, xs,xe,ys,ye)
        if is_success
            y_max_total = max(y_max, y_max_total)
        end
    end
    # simulate(7, 2, xs,xe,ys,ye)
    y_max_total
end

function solution_d17_2(input_file)
    (xs, xe), (ys, ye) = parse_input(input_file)
    c = 0
    for vx = -500:500, vy = -500:500
        is_success, y_max = simulate(vx, vy, xs,xe,ys,ye)
        c += is_success
    end
    # simulate(7, 2, xs,xe,ys,ye)
    c
end

# solution_d17_1("d17/input.txt")
# solution_d17_1("d17/input2.txt")
# solution_d17_2("d17/input.txt")
solution_d17_2("d17/input2.txt")