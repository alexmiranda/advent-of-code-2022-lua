local day12 = {}

-- luacheck: ignore inspect
local inspect = require("inspect")
local bit32 = require("bit32")
local StringBuffer = require("lib.string_buffer")

-- local READ_CHAR_MASK = 1 << 7
-- local LEFT_POSITION = READ_CHAR_MASK << 1
-- local UP_POSITION = LEFT_POSITION << 1
-- local RIGHT_POSITION = UP_POSITION << 1
-- local DOWN_POSITION = RIGHT_POSITION << 1
local READ_CHAR_MASK = bit32.lshift(1, 7) -- LURDCCCCCCC
local LEFT_POSITION = bit32.lshift(READ_CHAR_MASK, 1)
local UP_POSITION = bit32.lshift(LEFT_POSITION, 1)
local RIGHT_POSITION = bit32.lshift(UP_POSITION, 1)
local DOWN_POSITION = bit32.lshift(RIGHT_POSITION, 1)
local START = "S"
local GOAL = "E"

local Heightmap = {}
local Distances = {}

function Heightmap:new(heightmap)
    heightmap = heightmap or {}
    setmetatable(heightmap, self)
    self.__index = self
    return heightmap
end

function Heightmap:__tostring()
    local buf = StringBuffer:new()
    for _, row in ipairs(self) do
        for _, col in ipairs(row) do
            buf:append(" " .. string.char(col % READ_CHAR_MASK) .. "  ")
        end
        buf:append("\n")
    end
    return tostring(buf)
end

function Distances:new(distances)
    distances = distances or {}
    setmetatable(distances, self)
    self.__index = self
    return distances
end

function Distances:__tostring()
    local buf = StringBuffer:new()
    for _, row in ipairs(self) do
        for _, col in ipairs(row) do
            if col ~= -1 then
                buf:append(string.format(" %02d ", col))
            else
                buf:append(" NA ")
            end
        end
        buf:append("\n")
    end
    return tostring(buf)
end

local NEIGHBOURS = {
    {
        direction = LEFT_POSITION,
        opposite = RIGHT_POSITION,
        delta_x = -1,
        delta_y = 0,
    },
    {
        direction = UP_POSITION,
        opposite = DOWN_POSITION,
        delta_x = 0,
        delta_y = -1,
    },
    {
        direction = RIGHT_POSITION,
        opposite = LEFT_POSITION,
        delta_x = 1,
        delta_y = 0,
    },
    {
        direction = DOWN_POSITION,
        opposite = UP_POSITION,
        delta_x = 0,
        delta_y = 1,
    },
}

local function height(node)
    if node == START then
        return ("a"):byte()
    elseif node == GOAL then
        return ("z"):byte()
    end
    return (node:byte())
end

local function neighbours(heightmap, pos)
    local result = {}
    local v = heightmap[pos.y][pos.x]
    local c = string.char(v % READ_CHAR_MASK)
    local h = height(c)
    local map_len, map_width = #heightmap, #heightmap[1]
    for _, neighbour in ipairs(NEIGHBOURS) do
        local nx, ny = pos.x + neighbour.delta_x, pos.y + neighbour.delta_y
        if nx >= 1 and nx <= map_width
            and ny >= 1 and ny <= map_len
            and bit32.band(v, neighbour.direction) == 0 then
            local nv = heightmap[ny][nx] % READ_CHAR_MASK
            if height(string.char(nv)) >= h - 1 then
                table.insert(result, { x = nx, y = ny })
                heightmap[pos.y][pos.x] = bit32.bor(heightmap[pos.y][pos.x], neighbour.direction)
                heightmap[ny][nx] = bit32.bor(heightmap[ny][nx], neighbour.opposite)
            end
        end
    end
    -- print(inspect(result))
    return result
end

local function calculate_distances_to_goal(heightmap, goal)
    local distances = {}
    for i = 1, #heightmap do
        local row = {}
        table.insert(distances, row)
        for _ = 1, #heightmap[i] do
            table.insert(row, 0 / 0) -- nan
        end
    end

    local queue = {}
    table.insert(queue, { pos = goal, dist = 0 })
    distances[goal.y][goal.x] = 0

    repeat
        local it = table.remove(queue, 1)
        for _, neighbour in ipairs(neighbours(heightmap, it.pos)) do
            assert(neighbour.x ~= it.pos.x or neighbour.y ~= it.pos.y)
            -- assert(neighbour.x ~= goal.x or neighbour.y ~= goal.y)

            local curr_dist = distances[neighbour.y][neighbour.x]
            curr_dist = math.min(curr_dist, it.dist + 1)
            distances[neighbour.y][neighbour.x] = curr_dist
            table.insert(queue, { pos = neighbour, dist = curr_dist })
        end
    until #queue == 0
    return Distances:new(distances)
end

function day12.parse_input(input)
    local heightmap, start, goal, aa = {}, {}, {}, {}
    local prev = "\n"
    for c in input:gmatch(".") do
        if (prev == "\n") then
            table.insert(heightmap, {})
        end
        if c ~= "\n" then
            local row = heightmap[#heightmap]
            table.insert(row, c:byte())
            if c == START then
                start.x = #row
                start.y = #heightmap
                table.insert(aa, start)
            elseif c == GOAL then
                goal.x = #row
                goal.y = #heightmap
            elseif c == "a" then
                table.insert(aa, { x = #row, y = #heightmap })
            end
        end
        prev = c
    end
    -- print(inspect(heightmap))
    -- print(inspect(start))
    -- print(inspect(goal))
    -- print(inspect(aa))
    return Heightmap:new(heightmap), start, goal, aa
end

function day12.shortest_distance(heightmap, start, goal)
    start = #start == 0 and { start } or start
    local distances = calculate_distances_to_goal(heightmap, goal)
    -- print(heightmap)
    -- print(distances)
    -- print(inspect(start))

    local min = 0 / 0 -- nan
    for _, a in ipairs(start) do
        -- we filter out NaN from all of the distances
        if distances[a.y][a.x] == distances[a.y][a.x] then
            min = math.min(min, distances[a.y][a.x])
        end
    end
    return min
end

return day12
