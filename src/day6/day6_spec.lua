---@diagnostic disable: undefined-global

describe("day6", function()
    local day6 = require("day6")
    local puzzle_input = nil

    setup(function()
        local f = assert(io.open("src/day6/input", "r"))
        puzzle_input = f:read("*all"):gsub("%n+$", "")
    end)

    it("example - part 1", function()
        local tests = {
            { text = "mjqjpqmgbljsphdztnvjfqwrcgsmlb", start_of_packet = 7 },
            { text = "bvwbjplbgvbhsrlpgdmjqwftvncz", start_of_packet = 5 },
            { text = "nppdvjthqldpwncqszvftbrmjlhg", start_of_packet = 6 },
            { text = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", start_of_packet = 10 },
            { text = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", start_of_packet = 11 },
        }
        for _, t in ipairs(tests) do
            assert.are.equals(t.start_of_packet, day6.start_of_packet(t.text))
        end
    end)

    it("puzzle input - part 1", function()
        assert.are_equals(1848, day6.start_of_packet(puzzle_input))
    end)

    it("example - part 2", function()
        local tests = {
            { text = "mjqjpqmgbljsphdztnvjfqwrcgsmlb", start_of_message = 19 },
            { text = "bvwbjplbgvbhsrlpgdmjqwftvncz", start_of_message = 23 },
            { text = "nppdvjthqldpwncqszvftbrmjlhg", start_of_message = 23 },
            { text = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", start_of_message = 29 },
            { text = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", start_of_message = 26 },
        }
        for _, t in ipairs(tests) do
            assert.are.equals(t.start_of_message, day6.start_of_message(t.text))
        end
    end)

    it("puzzle input - part 2", function()
        assert.are_equals(2308, day6.start_of_message(puzzle_input))
    end)
end)
