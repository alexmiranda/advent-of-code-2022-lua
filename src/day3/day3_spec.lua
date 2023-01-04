---@diagnostic disable: undefined-global

local EXAMPLE = [[
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
]]

describe("day3", function()
    local day3 = require("day3")

    it("example - part 1", function()
        assert.are.equal(157, day3.sum_of_priorities(EXAMPLE))
    end)

    it("puzzle input - part 1", function()
        local f = assert(io.open("src/day3/input", "r"))
        local content = f:read("*all")
        assert.are.equal(7848, day3.sum_of_priorities(content))
    end)
end)
