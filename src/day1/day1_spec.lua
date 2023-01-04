---@diagnostic disable: undefined-global

describe("day1", function()
    local day1 = require("day1")

    local example = [[
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
    ]]

    local puzzle_input = nil

    setup(function ()
        local f = assert(io.open("src/day1/input", "r"))
        puzzle_input = f:read("*all")
    end)

    it("example - part 1", function()
        local ans = day1.top_calories(example)
        assert.are.equal(ans, 24000)
    end)

    it("puzzle input - part 1", function()
        local ans = day1.top_calories(puzzle_input)
        assert.are.equal(ans, 71780)
    end)

    it("example - part 2", function()
        local ans = day1.top_calories(example, 3)
        assert.are.equal(ans, 45000)
    end)

    it("puzzle input - part 2", function()
        local ans = day1.top_calories(puzzle_input, 3)
        assert.are.equal(ans, 212489)
    end)
end)
