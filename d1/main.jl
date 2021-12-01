function solution_p1(input_file)
    s = open(input_file) do f
        parse.(Int, readlines(f))
    end
    c = 0
    for i in 1:length(s)-1
        if s[i+1] > s[i]
            c += 1
        end
    end
    c
end

function solution_p2(input_file)
    s = open(input_file) do f
        parse.(Int, readlines(f))
    end
    s3 = s[1:end-2] + s[2:end-1] + s[3:end]
    c = 0
    for i in 1:length(s3)-1
        if s3[i+1] > s3[i]
            c += 1
        end
    end
    c
end

solution_p1("input.txt")
solution_p1("input2.txt")

solution_p2("input.txt")
solution_p2("input2.txt")
