---@diagnostic disable: undefined-global

describe("day11", function()
    local day11 = require("day11")
    local example = nil
    local puzzle_input = nil

    setup(function()
        example = assert(io.open("src/day11/example", "r")):read("*all")
        puzzle_input = assert(io.open("src/day11/input", "r")):read("*all")
    end)

    it("example - part 1", function()
        local troop = day11.parse_input(example)
        local answer = day11.calculate_monkey_business_level(troop, 20, 3)
        assert.are.equals(10605, answer)
    end)

    it("puzzle input - part 1", function()
        local troop = day11.parse_input(puzzle_input)
        local answer = day11.calculate_monkey_business_level(troop, 20, 3)
        assert.are.equals(101436, answer)
    end)
end)
