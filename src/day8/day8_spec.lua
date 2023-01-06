---@diagnostic disable: undefined-global

describe("day8", function()
    local day8 = require("day8")

    local EXAMPLE = [[
30373
25512
65332
33549
35390
]]

    it("example - part 1", function()
        assert.are.equals(21, day8.count_visible_trees(EXAMPLE))
    end)

    it("puzzle input - part 1", function()
        local f = assert(io.open("src/day8/input", "r"))
        local puzzle_input = f:read("*all")
        assert.are.equals(1812, day8.count_visible_trees(puzzle_input))
    end)

    it("example - part 2", function()
        assert.are.equals(8, day8.highest_scenic_score(EXAMPLE))
    end)

    it("puzzle input - part 2", function()
        local f = assert(io.open("src/day8/input", "r"))
        local puzzle_input = f:read("*all")
        assert.are.equals(315495, day8.highest_scenic_score(puzzle_input))
    end)
end)
