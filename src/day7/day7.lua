local day7 = {}

-- luacheck: ignore inspect
local inspect = require("inspect")

local function File(file_name, file_size)
    return {
        name = file_name,
        size = function()
            return file_size
        end,
    }
end

local function Folder(folder_name, parent_folder)
    return {
        name = folder_name,
        parent = parent_folder,
        children = {},
        size = function(self)
            if self._size then
                return self._size
            end
            local size = 0
            for _, file in pairs(self.children) do
                size = size + file:size()
            end
            self._size = size
            return size
        end,
    }
end

function day7.parse_terminal_output(output)
    local root = Folder "/"
    local node = nil
    local parent = nil
    for line in output:gmatch("(.-)\n") do
        -- print(line)
        if line:match("%$ cd (.+)") then
            local dir_name = line:match("%S+$")
            if dir_name == "/" then
                node = root
            elseif dir_name == ".." then
                node = parent
                parent = node.parent
            else
                parent = node
                node = node.children[dir_name]
            end
        elseif line:match("dir %w+") then
            local dir_name = line:match("%w+$")
            node.children[dir_name] = Folder(dir_name, node)
        elseif line:match("%d+ %S+") then
            local file_size, file_name = line:match("(%d+) (%S+)")
            table.insert(node.children, File(file_name, tonumber(file_size)))
        end
    end
    -- print(inspect(root))
    return root
end

function day7.find_folders_under(node, size)
    local queue = {}
    table.insert(queue, node)
    local total_size = 0
    repeat
        node = table.remove(queue, 1)
        -- print(inspect(node))
        if node:size() < size then
            total_size = total_size + node:size()
        end
        for _, child in pairs(node.children) do
            if child.children then
                table.insert(queue, child)
            end
        end
    until next(queue) == nil
    return total_size
end

return day7
