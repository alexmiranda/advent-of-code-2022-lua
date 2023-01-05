local day4 = {}

function day4.count_assignments_fully_contained(input)
    local counter = 0
    for a1, a2, b1, b2 in input:gmatch("(%d+)-(%d+),(%d+)-(%d+)") do
        a1, a2, b1, b2 = tonumber(a1), tonumber(a2), tonumber(b1), tonumber(b2)
        -- print("a1", a1, "a2", a2, "b1", b1, "b2", b2)
        if (a1 >= b1 and a2 <= b2) or (b1 >= a1 and b2 <= a2) then
            counter = counter + 1
        end
    end
    return counter
end

function day4.count_assignments_overlapping(input)
    local counter = 0
    for a1, a2, b1, b2 in input:gmatch("(%d+)-(%d+),(%d+)-(%d+)") do
        a1, a2, b1, b2 = tonumber(a1), tonumber(a2), tonumber(b1), tonumber(b2)
        -- print("a1", a1, "a2", a2, "b1", b1, "b2", b2)
        if (a1 >= b1 and a1 <= b2) or
            (a2 >= b1 and a2 <= b2) or
            (b1 >= a1 and b1 <= a2) or
            (b2 >= a1 and b2 <= a2) then
            counter = counter + 1
        end
    end
    return counter
end

return day4
