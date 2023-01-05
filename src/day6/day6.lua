local day6 = {}

local function unique_chars(str)
    local seen = {}
    for i = 1, #str do
        local letter = str:sub(i, i)
        -- found a repeated letter, aborting...
        if seen[letter] then return false end
        seen[letter] = true
    end
    return true
end

local function find_unique_sequence(text, length)
    for i = length, #text do
        local str = text:sub(i - length + 1, i)
        assert(#str == length)
        if unique_chars(str) then
            return i
        end
    end
end

function day6.start_of_packet(text)
    return find_unique_sequence(text, 4)
end

function day6.start_of_message(text)
    return find_unique_sequence(text, 14)
end

return day6