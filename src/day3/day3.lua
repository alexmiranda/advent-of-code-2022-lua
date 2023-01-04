local day3 = {}

local LOWER_A_BYTE = ("a"):byte(1, 1)
local UPPER_A_BYTE = ("A"):byte(1, 1)

local function get_priority_of(character)
    -- print(character, character:byte(1, 1))
    if character:match("[a-z]") then
        local v = character:byte(1, 1) - LOWER_A_BYTE + 1
        assert(v >= 1 and v <= 26)
        return v
    elseif character:match("[A-Z]") then
        local v = 26 + character:byte(1, 1) - UPPER_A_BYTE + 1
        assert(v >= 27 and v <= 52)
        return v
    end
    error("unexpected character: " .. character)
end

local function priorities(s)
    local l = #s / 2
    local left = s:sub(1, l)
    local right = s:sub(l + 1, #s)

    -- find common
    for i = 1, #left do
        local c = left:sub(i, i)
        if right:find(c, 1, true) then
            return get_priority_of(c)
        end
    end

    -- not found
    return 0
end

local function group_priorities(group)
    local a, b, c = table.unpack(group)
    for i = 1, #a do
        local char = a:sub(i, i)
        if b:find(char, 1, true) and c:find(char, 1, true) then
            return get_priority_of(char)
        end
    end

    -- not found
    return 0
end

function day3.sum_of_priorities(input)
    local sum = 0
    for line in input:gmatch("[^\n]+") do
        -- print(line)
        sum = sum + priorities(line)
    end
    return sum
end

function day3.sum_of_group_priorities(input)
    local group = {}
    local i = 1
    local sum = 0
    for line in input:gmatch("[^\n]+") do
        table.insert(group, line)
        if i % 3 == 0 then
            assert(#group == 3)
            sum = sum + group_priorities(group)
            group = {}
        end
        i = i + 1
    end
    return sum
end

return day3
