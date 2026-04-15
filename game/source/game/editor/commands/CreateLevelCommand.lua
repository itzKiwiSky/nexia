return function(levelname, song)
    -- create level files --
    local filedata = json.encode(song:getRepresentation())
    local root = levelname .. "/"

    love.filesystem.createDirectory(root)
    local path = string.format("%s/data.json", root)
    local file = love.filesystem.newFile(path)
    file:write()
    file:close()
end
