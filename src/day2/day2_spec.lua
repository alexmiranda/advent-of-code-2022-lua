---@diagnostic disable: undefined-global

describe("day2", function()
    local day2 = require("day2")
    local puzzle_input = nil

    local example = [[
A Y
B X
C Z
    ]]

    setup(function ()
        local f = assert(io.open("src/day2/input", "r"))
        puzzle_input = f:read("*all")
    end)

    it("example - part 1", function ()
        local ans = day2.total_score(example)
        assert.are.equal(15, ans)
    end)

    it("puzzle input - part 1", function ()
        local ans = day2.total_score(puzzle_input)
        assert.are.equal(17189, ans)
    end)
end)