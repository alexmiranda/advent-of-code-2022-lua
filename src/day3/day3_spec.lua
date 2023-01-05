---@diagnostic disable: undefined-global

describe("day3", function()
    local day3 = require("day3")
    local puzzle_input = nil
    local EXAMPLE = [[
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
]]

    setup(function ()
        local f = assert(io.open("src/day3/input", "r"))
        puzzle_input = f:read("*all")
    end)

    it("example - part 1", function()
        assert.are.equal(157, day3.sum_of_priorities(EXAMPLE))
    end)

    it("puzzle input - part 1", function()
        assert.are.equal(7848, day3.sum_of_priorities(puzzle_input))
    end)

    it("example - part 2", function()
        assert.are.equal(70, day3.sum_of_group_priorities(EXAMPLE))
    end)

    it("puzzle input - part 2", function()
        assert.are.equal(2616, day3.sum_of_group_priorities(puzzle_input))
    end)
end)
