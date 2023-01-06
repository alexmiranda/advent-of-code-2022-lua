local day9 = {}

--luacheck: ignore inspect
local inspect = require("inspect")

function day9.count_visited(input)
    local head, tail = { x = 0, y = 0 }, { x = 0, y = 0 }
    local hash = function(pos)
        return tostring(pos.y) .. "," .. tostring(pos.x)
    end
    local seen = { [hash(tail)] = true }
    local counter = 1
    for dir, n in input:gmatch("([LURD]) (%d+)") do
        -- print(dir, n)
        for _ = 1, tonumber(n) do
            if dir == "L" then
                head.x = head.x - 1
            elseif dir == "U" then
                head.y = head.y - 1
            elseif dir == "R" then
                head.x = head.x + 1
            elseif dir == "D" then
                head.y = head.y + 1
            end

            local delta_x, delta_y = head.x - tail.x, head.y - tail.y
            if math.abs(delta_x) > 1 or math.abs(delta_y) > 1 then
                if delta_x ~= 0 then tail.x = tail.x + (delta_x / math.abs(delta_x)) end
                if delta_y ~= 0 then tail.y = tail.y + (delta_y / math.abs(delta_y)) end
                local h = hash(tail)
                if not seen[h] then
                    seen[h] = true
                    counter = counter + 1
                end
            end
        end
        -- print(inspect(seen))
    end
    return counter
end

return day9
