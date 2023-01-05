---@diagnostic disable: undefined-global

describe("day4", function()
    local day4 = require("day4")
    local puzzle_input = nil
    local EXAMPLE = [[
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
]]

    setup(function()
        local f = assert(io.open("src/day4/input", "r"))
        puzzle_input = f:read("*all")
    end)

    it("example - part 1", function()
        assert.are.equal(2, day4.count_assignments_fully_contained(EXAMPLE))
    end)

    it("puzzle input - part 1", function()
        assert.are.equal(477, day4.count_assignments_fully_contained(puzzle_input))
    end)

    it("example - part 2", function()
        assert.are.equal(4, day4.count_assignments_overlapping(EXAMPLE))
    end)

    it("puzzle input - part 2", function()
        assert.are.equal(830, day4.count_assignments_overlapping(puzzle_input))
    end)
end)
