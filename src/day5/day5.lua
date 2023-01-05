local day5 = {}

-- luacheck: ignore inspect
local inspect = require("inspect")

function day5.parse_input(input)
    local stacks = {}
    local instructions = {}
    local parsing_instructions = false

    for line in input:gmatch("(.-)\n") do
        if not line:match("%S") then
            -- end of the stacks, should parse the instructions lines next
            parsing_instructions = true

        elseif not parsing_instructions then
            -- we read the characters in position 2, 6, 10... and so on
            -- and push them to the respective stack number
            local stack_no = 1
            for i = 2, #line, 4 do
                local crate = line:sub(i, i)
                -- skip stack numbers because these are the indexes of the stacks table
                if crate:match("[A-Z]") then
                    stacks[stack_no] = stacks[stack_no] or {}
                    table.insert(stacks[stack_no], 1, line:sub(i, i))
                end
                stack_no = stack_no + 1
            end

        else
            local amount, from, to = line:match("move (%d+) from (%d+) to (%d+)")
            table.insert(instructions, {
                amount = tonumber(amount),
                from = tonumber(from),
                to = tonumber(to),
            })
        end
    end

    -- print(inspect(stacks))
    -- print(inspect(instructions))
    return stacks, instructions
end

function day5.move_crates(stacks, instructions)
    local answer = ""
    for _, instruction in ipairs(instructions) do
        local from = stacks[instruction.from]
        local to = stacks[instruction.to]
        for _ = 1, instruction.amount do
            local crate = from[#from]
            table.remove(from, #from)
            table.insert(to, crate)
        end
    end
    for _, stack in ipairs(stacks) do
        answer = answer .. stack[#stack]
    end
    return answer
end

function day5.move_multiple_crates(stacks, instructions)
    local answer = ""
    for _, instruction in ipairs(instructions) do
        local from = stacks[instruction.from]
        local to = stacks[instruction.to]
        local pos = #from - instruction.amount + 1
        for _ = 1, instruction.amount do
            local crate = from[pos]
            table.remove(from, pos)
            table.insert(to, crate)
        end
    end
    for _, stack in ipairs(stacks) do
        answer = answer .. stack[#stack]
    end
    return answer
end

return day5
