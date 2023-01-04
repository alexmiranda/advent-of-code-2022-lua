local day2 = {}

-- local inspect = require("inspect")

local SHAPES = {
    ["ROCK"] = {
        base_score = 1,
        represented_by = { ["A"] = true, ["X"] = true },
        beaten_by = { ["PAPER"] = true }
    },
    ["PAPER"] = {
        base_score = 2,
        represented_by = { ["B"] = true, ["Y"] = true },
        beaten_by = { ["SCISSOR"] = true }
    },
    ["SCISSOR"] = {
        base_score = 3,
        represented_by = { ["C"] = true, ["Z"] = true },
        beaten_by = { ["ROCK"] = true }
    },
}

local function score(opponent, you)
    local find_shape = function(rep)
        for k, v in pairs(SHAPES) do
            if v.represented_by[rep] then
                return k, v
            end
        end
    end

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

function day2.total_score(input)
    local total_score = 0
    for opponent, you in input:gmatch("(%w+) (%w+)") do
        total_score = total_score + score(opponent, you)
    end
    return total_score
end

return day2
