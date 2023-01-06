local day10 = {}

function day10.sum_signal_strengths(input)
    local x, cycle, sum = 1, 1, 0
    local screen = string.rep(string.rep(".", 40), 6, "\n")
    -- print(screen)
    local tick = function()
        -- local row = (cycle - 1) // 40
        local row = math.floor((cycle - 1) / 40)
        local col = cycle - (row * 40)
        if math.abs(x - (col - 1)) <= 1 then
            local pos = row * 40 + row + col
            screen = screen:sub(1, pos - 1) .. "#" .. screen:sub(pos + 1)
        end
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
    return sum, screen
end

return day10
