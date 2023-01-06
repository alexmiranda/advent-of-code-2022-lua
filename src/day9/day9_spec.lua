---@diagnostic disable: undefined-global

describe("day9", function()
    local day9 = require("day9")
    local puzzle_input = nil

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

    local LARGER_EXAMPLE = [[
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
]]

    setup(function()
        local f = assert(io.open("src/day9/input", "r"))
        puzzle_input = f:read("*all")
    end)

    it("example - part 1", function()
        local answer = day9.count_visited(EXAMPLE)
        assert.are.equals(13, answer)
        assert.are.equals(answer, day9.count_visited_long_rope(EXAMPLE, 2))
    end)

    it("puzzle input - part 1", function()
        local answer = day9.count_visited(puzzle_input)
        assert.are.equals(6067, answer)
        assert.are.equals(answer, day9.count_visited_long_rope(puzzle_input, 2))
    end)

    it("example - part 2", function()
        local answer = day9.count_visited_long_rope(LARGER_EXAMPLE, 10)
        assert.are.equals(36, answer)
    end)

    it("puzzle input - part 2", function()
        local answer = day9.count_visited_long_rope(puzzle_input, 10)
        assert.are.equals(2471, answer)
    end)
end)
