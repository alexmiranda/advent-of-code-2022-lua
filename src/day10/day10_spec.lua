---@diagnostic disable: undefined-global

describe("day10", function()
    local day10 = require("day10")
    local example = nil
    local puzzle_input = nil

    setup(function()
        example = assert(io.open("src/day10/example", "r")):read("*all")
        puzzle_input = assert(io.open("src/day10/input", "r")):read("*all")
    end)

    it("example", function()
        local signal_strength, screen = day10.sum_signal_strengths(example)
        assert.are.equals(13140, signal_strength)
        local expected_screen = [[
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....]]
        assert.are.equals(expected_screen, screen)
    end)

    it("puzzle input", function()
        local signal_strength, screen = day10.sum_signal_strengths(puzzle_input)
        assert.are.equals(13820, signal_strength)
        local expected_screen = [[
####.#..#..##..###..#..#..##..###..#..#.
...#.#.#..#..#.#..#.#.#..#..#.#..#.#.#..
..#..##...#....#..#.##...#....#..#.##...
.#...#.#..#.##.###..#.#..#.##.###..#.#..
#....#.#..#..#.#.#..#.#..#..#.#.#..#.#..
####.#..#..###.#..#.#..#..###.#..#.#..#.]]
        assert.are.equals(expected_screen, screen)
    end)

    it("pixel positioning on a string", function()
        local values = { 1, 39, 40, 42, 80, 81, 83, 121, 122, 124 }
        for i, cycle in ipairs({ 1, 39, 40, 41, 79, 80, 81, 119, 120, 121 }) do
            local row = math.floor((cycle - 1) / 40)
            local col = cycle - (row * 40)
            local pixel_position = row * 40 + row + col
            -- print(cycle, row, col, pixel_position)
            assert.are.equals(values[i], pixel_position)
        end
    end)
end)
