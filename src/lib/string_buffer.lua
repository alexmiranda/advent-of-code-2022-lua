-- https://www.lua.org/pil/11.6.html
local StringBuffer = {}

-- luacheck: ignore inspect
local inspect = require("inspect")

local insert = table.insert
local remove = table.remove
local concat = table.concat
local len = string.len

function StringBuffer:new()
    local buf = { "" }
    setmetatable(buf, self)
    self.__index = self
    return buf
end

function StringBuffer:append(s)
    insert(self, s)
    for i = #self - 1, 1, -1 do
        if len(self[i]) > len(self[i + 1]) then
            break
        end
        self[i] = self[i] .. remove(self)
    end
end

function StringBuffer:__tostring()
    return concat(self, "")
end

return StringBuffer
