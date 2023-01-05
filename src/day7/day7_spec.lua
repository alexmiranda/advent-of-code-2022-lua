---@diagnostic disable: undefined-global

describe("day7", function()
    local day7 = require("day7")
    local test_tree = nil
    local puzzle_tree = nil
    local available_disk_space = 70000000
    local required_free_space = 30000000

    local EXAMPLE = [[
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
]]

    setup(function()
        test_tree = day7.parse_terminal_output(EXAMPLE)

        local f = assert(io.open("src/day7/input", "r"))
        local puzzle_input = f:read("*all")
        puzzle_tree = day7.parse_terminal_output(puzzle_input)
    end)

    it("example - part 1", function()
        local answer = day7.find_folders_under(test_tree, 100000)
        assert.are.equals(95437, answer)
    end)

    it("puzzle input - part 1", function()
        local answer = day7.find_folders_under(puzzle_tree, 100000)
        assert.are.equals(1778099, answer)
    end)

    it("example - part 2", function()
        local answer = day7.free_up_space(test_tree, available_disk_space, required_free_space)
        assert.are.equals(24933642, answer)
    end)

    it("puzzle input - part 2", function()
        local answer = day7.free_up_space(puzzle_tree, available_disk_space, required_free_space)
        assert.are.equals(1623571, answer)
    end)
end)
