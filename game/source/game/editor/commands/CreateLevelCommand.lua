return function(levelname, song)
    -- create level files --

    local root = levelname .. "/"

    love.filesystem.createDirectory(root)
    local path = string.format("%s/data.json", root)
    local file = love.filesystem.newFile(path)
    file:write()
end
