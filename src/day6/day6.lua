local day6 = {}

local function unique_chars(str)
    local set = {}
    for i = 1, #str do
        local letter = str:sub(i, i)
        -- found a repeated letter, aborting...
        if set[letter] then return false end
        set[letter] = true
    end
    return true
end

function day6.start_of_packet(text)
    for i = 4, #text do
        local str = text:sub(i - 4, i)
        if unique_chars(str) then
            return i - 1
        end
    end
end

return day6