---@diagnostic disable: undefined-global

describe("day5", function()
    local day5 = require("day5")

    -- luacheck: ignore
    local EXAMPLE = [[
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
    ]]

    it("should parse the example input", function()
        local stacks, instructions = day5.parse_input(EXAMPLE)
        assert.is_truthy(stacks[1])
        assert.are.same({ "Z", "N" }, stacks[1])
        assert.is_truthy(stacks[2])
        assert.are.same({ "M", "C", "D" }, stacks[2])
        assert.is_truthy(stacks[3])
        assert.are.same({ "P" }, stacks[3])

        assert.are.same({
            { amount = 1, from = 2, to = 1 },
            { amount = 3, from = 1, to = 3 },
            { amount = 2, from = 2, to = 1 },
            { amount = 1, from = 1, to = 2 },
        }, instructions)
    end)

    it("example - part 1", function()
        local stacks, instructions = day5.parse_input(EXAMPLE)
        local answer = day5.move_crates(stacks, instructions)
        assert.are.equals("CMZ", answer)
    end)

    it("puzzle input - part 1", function()
        local f = assert(io.open("src/day5/input", "r"))
        local puzzle_input = f:read("*all")
        local stacks, instructions = day5.parse_input(puzzle_input)
        local answer = day5.move_crates(stacks, instructions)
        assert.are.equals("GRTSWNJHH", answer)
    end)
end)
