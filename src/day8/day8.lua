local day8 = {}

-- luacheck: ignore inspect
local inspect = require("inspect")

local function parse_input(input)
    local grid = {}
    local row, prev = 0, "\n"
    for i = 1, #input do
        local curr = input:sub(i, i)
        if prev == "\n" then
            row = row + 1
            grid[row] = {}
        end
        if curr ~= "\n" then
            table.insert(grid[row], tonumber(curr))
        end
        prev = curr
    end
    return grid
end

local function is_visible(grid, i, j, v)
    local visible = true
    for col = j - 1, 1, -1 do
        if grid[i][col] >= v then
            visible = false
            break
        end
    end
    if visible then return visible end

    visible = true
    for col = j + 1, #grid[i] do
        if grid[i][col] >= v then
            visible = false
            break
        end
    end
    if visible then return visible end

    visible = true
    for row = i - 1, 1, -1 do
        if grid[row][j] >= v then
            visible = false
            break
        end
    end
    if visible then return visible end

    visible = true
    for row = i + 1, #grid do
        if grid[row][j] >= v then
            visible = false
            break
        end
    end
    return visible
end

local function calculate_scenic_score(grid, i, j, v)
    local left_score = 0
    for col = j - 1, 1, -1 do
        left_score = left_score + 1
        if grid[i][col] >= v then
            break
        end
    end
    if left_score == 0 then return 0 end

    local right_score = 0
    for col = j + 1, #grid[i] do
        right_score = right_score + 1
        if grid[i][col] >= v then
            break
        end
    end
    if right_score == 0 then return 0 end

    local up_score = 0
    for row = i - 1, 1, -1 do
        up_score = up_score + 1
        if grid[row][j] >= v then
            break
        end
    end
    if up_score == 0 then return 0 end

    local down_score = 0
    for row = i + 1, #grid do
        down_score = down_score + 1
        if grid[row][j] >= v then
            break
        end
    end

    return up_score * left_score * down_score * right_score
end

function day8.count_visible_trees(input)
    local grid = parse_input(input)
    local counter = (#grid * 2) + ((#grid[1] - 2) * 2)
    for i = 2, #grid - 1 do
        for j = 2, #grid[i] - 1 do
            counter = counter + (is_visible(grid, i, j, grid[i][j]) and 1 or 0)
        end
    end
    return counter
end

function day8.highest_scenic_score(input)
    local grid = parse_input(input)
    local scenic_score = 0
    for i = 2, #grid - 1 do
        for j = 2, #grid[i] - 1 do
            scenic_score = math.max(scenic_score, calculate_scenic_score(grid, i, j, grid[i][j]))
        end
    end
    return scenic_score
end

return day8
