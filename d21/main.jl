using DataStructures

mutable struct Dice
    state::Int
    nrolls::Int
    Dice() = new(0, 0)
end

function roll!(dice::Dice)
    dice.state += 1
    dice.nrolls += 1
    if dice.state > 100
        dice.state = 1
    end
    return dice.state
end

function triple_roll!(dice::Dice)
    roll!(dice) + roll!(dice) + roll!(dice)
end

function parse_input(input_file)
    open(input_file) do f
        map(readlines(f)) do line
            parse(Int, split(line, ": ")[2])
        end
    end
end

function solution_d21_1(input_file)
    positions = parse_input(input_file)
    points = [0, 0]

    d = Dice()
    k = 1
    while points[1] < 1000 && points[2] < 1000
        positions[k] = mod1(triple_roll!(d) + positions[k], 10)
        points[k] += positions[k]
        k = mod1(k + 1, 2)
    end
    
    d.nrolls * minimum(points)
end

struct Game
    positions::Vector{Int}
    points::Vector{Int}
    whose_turn::Int
end

function check_if_any_not_finished(games)
    for g in keys(games)
        if any(g.points .< 21)
            return true
        end
    end
    return false
end

function simulate(game)
    new_games = DefaultDict{Game, Int}(0)
    new_games[game] = 1
    for step in 1:3, i in 1:3
        for (game, n) in copy(new_games)
            positions = game.positions
            points = game.points
            k = game.whose_turn
            positions[k] = mod1(positions[k] + i, 10)
            points[k] += positions[k]
            next_player = step == 3 ? mod1(k+1, 2) : k
            delete!(new_games,game)
            ng = Game(positions, points, next_player)
            new_games[ng] += n
        end
    end
    return new_games
end

function solution_d21_2(input_file)
    positions = parse_input(input_file)
    games = DefaultDict{Game, Int}(0)
    g0 = Game([positions[1], positions[2]], [0, 0], 1)
    games[g0] = 1
    while check_if_any_not_finished(games)
        for (game, n) in copy(games)
            if any(game.points .> 21)
                continue
            end
            new_games = simulate(game)
            delete!(games, game)
            for (ngame, m) in new_games
                games[ngame] += m*n
            end
        end
    end
    @show games
    wins = [0, 0]
    for (game, n) in games
        if game.points[1] > game.points[2]
            wins[1] += n
        else
            wins[2] += n
        end
    end
    wins
end

# solution_d21_1("d21/input.txt")
# solution_d21_1("d21/input2.txt")
solution_d21_2("d21/input.txt")