local day11 = {}

-- luacheck: ignore inspect
local inspect = require("inspect")

local Monkey = {}

function Monkey:new(obj)
    obj = obj or {
        inspection_count = 0,
        items = {},
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Monkey:inspect_items(troop, relief, div_by_product)
    div_by_product = div_by_product or 1
    -- print("inspect items of", inspect(self))
    while next(self.items) do
        self.inspection_count = self.inspection_count + 1
        local item = table.remove(self.items, 1)
        local left_op = self.left_operand == "old" and item or tonumber(self.left_operand)
        local right_op = self.right_operand == "old" and item or tonumber(self.right_operand)
        local worry_level = 0
        if self.operator == "+" then
            worry_level = math.floor((left_op + right_op) / relief) % div_by_product
        elseif self.operator == "*" then
            worry_level = math.floor((left_op * right_op) / relief) % div_by_product
        end
        if worry_level % self.divisible_by == 0 then
            table.insert(troop[self.if_true].items, worry_level)
        else
            table.insert(troop[self.if_false].items, worry_level)
        end
    end
end

function day11.parse_input(input)
    local troop = {}
    local monkey = nil
    for key, value in input:gmatch("%s*([^:]+):([^\n]*)") do
        -- print(key, value)
        if key:match("Monkey (%d+)") then
            monkey = Monkey:new()
            troop[key:match("%d+$")] = monkey
            table.insert(troop, monkey)
        elseif key:match("Starting items") then
            for item in value:gmatch("(%d+)(,*)") do
                table.insert(monkey.items, tonumber(item))
            end
        elseif key:match("Operation") then
            local left_operand, operator, right_operand = value:match("new = (%w+) ([%+%*]) (%w+)")
            monkey.left_operand = left_operand
            monkey.operator = operator
            monkey.right_operand = right_operand
        elseif key:match("Test") then
            monkey.divisible_by = tonumber(value:match("%d+$"))
        elseif key:match("If true") then
            monkey.if_true = value:match("%d+$")
        elseif key:match("If false") then
            monkey.if_false = value:match("%d+$")
        end
    end
    -- print(inspect(troop))
    return troop
end

local function divisible_by_product(troop)
    local product = 1
    for _, monkey in pairs(troop) do
        product = product * monkey.divisible_by
    end
    return product
end

function day11.calculate_monkey_business_level(troop, rounds, relief)
    relief = relief or 1
    local div_by_product = divisible_by_product(troop)
    -- local div_by_product = 1
    for _ = 1, rounds do
        for _, monkey in ipairs(troop) do
            monkey:inspect_items(troop, relief, div_by_product)
        end
    end

    local top1, top2 = 0, 0
    for _, monkey in ipairs(troop) do
        if monkey.inspection_count >= top1 then
            top2 = top1
            top1 = monkey.inspection_count
        elseif monkey.inspection_count > top2 then
            top2 = monkey.inspection_count
        end
    end
    -- print(top1, top2)

    return top1 * top2
end

return day11
