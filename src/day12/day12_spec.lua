---@diagnostic disable: undefined-global

describe("day12", function()
    local day12 = require("day12")
    local puzzle_input = nil

    local EXAMPLE = [[
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
]]

    setup(function()
        puzzle_input = assert(io.open("src/day12/input", "r")):read("*all")
    end)

    it("example - part 1", function()
        local heightmap, start, goal = day12.parse_input(EXAMPLE)
        local answer = day12.shortest_distance(heightmap, start, goal)
        assert.are_equal(31, answer)
    end)

    it("puzzle input - part 1", function()
        local heightmap, start, goal = day12.parse_input(puzzle_input)
        local answer = day12.shortest_distance(heightmap, start, goal)
        assert.are_equal(484, answer)
    end)

    it("example - part 2", function()
        local heightmap, _, goal, aa = day12.parse_input(EXAMPLE)
        local answer = day12.shortest_distance(heightmap, aa, goal)
        assert.are_equal(29, answer)
    end)

    it("puzzle input - part 2", function()
        local heightmap, _, goal, aa = day12.parse_input(puzzle_input)
        local answer = day12.shortest_distance(heightmap, aa, goal)
        assert.are_equal(478, answer)
    end)
end)
