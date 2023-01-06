local day10 = {}

function day10.sum_signal_strengths(input)
    local x, cycle, sum = 1, 1, 0
    local tick = function()
        if cycle <= 220 and cycle % 40 == 20 then
            sum = sum + x * cycle
            -- print("cycle", cycle, "x", x, "sum", sum)
        end
        cycle = cycle + 1
    end

    for line in input:gmatch("(.-)\n") do
        tick()
        if line:match("addx %-*%d+") then
            tick() -- addx takes two cycles to complete
            x = x + tonumber(line:sub(line:find(" ") + 1))
        end
    end
    return sum
end

return day10
