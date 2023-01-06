---@diagnostic disable: undefined-global

describe("day10", function()
    local day10 = require("day10")
    local example = nil
    local puzzle_input = nil

    setup(function()
        example = assert(io.open("src/day10/example", "r")):read("*all")
        puzzle_input = assert(io.open("src/day10/input", "r")):read("*all")
    end)

    it("example - part 1", function()
        assert.are.equals(13140, day10.sum_signal_strengths(example))
    end)

    it("puzzle input - part 1", function()
        assert.are.equals(13820, day10.sum_signal_strengths(puzzle_input))
    end)
end)
