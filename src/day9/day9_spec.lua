---@diagnostic disable: undefined-global

describe("day9", function()
    local day9 = require("day9")

    local EXAMPLE = [[
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
]]

    it("example - part 1", function()
        local answer = day9.count_visited(EXAMPLE)
        assert.are.equals(13, answer)
    end)

    it("puzzle input - part 1", function()
        local f = assert(io.open("src/day9/input", "r"))
        local puzzle_input = f:read("*all")
        local answer = day9.count_visited(puzzle_input)
        assert.are.equals(6067, answer)
    end)
end)
