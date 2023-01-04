local day1 = {}

-- local inspect = require("inspect")

function day1.top_calories(input, n)
    input = input .. "\n"
    n = n or 1
    local elves = {}
    local counter = 0
    for s in input:gmatch("(.-)\n") do
        if s:match("%S") then
            counter = counter + tonumber(s)
        else
            table.insert(elves, #elves + 1, counter)
            counter = 0
        end
    end

    -- sort result
    table.sort(elves)
    elves = { table.unpack(elves, #elves - n + 1) }
    -- print("elves: ", inspect(elves))
    local sum = 0
    for _, v in pairs(elves) do
        sum = sum + v
    end
    return sum
end

return day1
