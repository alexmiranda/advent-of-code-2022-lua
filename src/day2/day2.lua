local day2 = {}

-- local inspect = require("inspect")

local LOSE = "X"
local DRAW = "Y"
local WIN = "Z"

local SHAPES = {
    ["ROCK"] = {
        base_score = 1,
        represented_by = { ["A"] = true, ["X"] = true },
        beaten_by = { ["PAPER"] = true },
        wins_over = "SCISSOR",
    },
    ["PAPER"] = {
        base_score = 2,
        represented_by = { ["B"] = true, ["Y"] = true },
        beaten_by = { ["SCISSOR"] = true },
        wins_over = "ROCK",
    },
    ["SCISSOR"] = {
        base_score = 3,
        represented_by = { ["C"] = true, ["Z"] = true },
        beaten_by = { ["ROCK"] = true },
        wins_over = "PAPER",
    },
}

local function find_shape(rep)
    for k, v in pairs(SHAPES) do
        if v.represented_by[rep] then
            return k, v
        end
    end
end

local function score(opponent, you)
    local _, opponent_shape = find_shape(opponent)
    local your_choice, your_choice_shape = find_shape(you)

    -- print("opponent_shape: ", inspect(opponent_shape))
    -- print("your_choice_shape: ", inspect(your_choice_shape))

    if opponent_shape == your_choice_shape then
        -- draw score
        return your_choice_shape.base_score + 3
    elseif opponent_shape.beaten_by[your_choice] then
        -- win score
        return your_choice_shape.base_score + 6
    else
        -- lose score
        return your_choice_shape.base_score
    end
end

local function choose_outcome(opponent, outcome)
    if outcome == DRAW then
        return opponent
    end

    local _, opponent_shape = find_shape(opponent)
    local your_choice = nil
    if outcome == WIN then
        local key, _ = next(opponent_shape.beaten_by)
        your_choice = SHAPES[key]
    elseif outcome == LOSE then
        your_choice = SHAPES[opponent_shape.wins_over]
    end

    local key, _ = next(your_choice.represented_by)
    return key
end

function day2.total_score(input)
    local total_score = 0
    for opponent, you in input:gmatch("(%w+) (%w+)") do
        total_score = total_score + score(opponent, you)
    end
    return total_score
end

function day2.total_score_revised(input)
    local total_score = 0
    for opponent, outcome in input:gmatch("(%w+) (%w+)") do
        total_score = total_score + score(opponent, choose_outcome(opponent, outcome))
    end
    return total_score
end

return day2
