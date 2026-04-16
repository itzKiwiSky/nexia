local function transformText(text)
    local txt = text:gsub(" ", "_")
    txt = txt:lower()
    return txt
end

return function(song)
    -- create level files --
    print(inspect(song))
    local filedata = json.encode(song:getRepresentation())
    local levelName = transformText(song.meta.title)
    local root = "user/created/" -- this is our file root --

    print(filedata)

    local folderName = string.format("%s/%s", root, levelName)
    if love.filesystem.getInfo(folderName) ~= nil then
        local message = "The level you're trying to create already exists, continuing will overwirte the existent level, are you sure you want to continue?"
        local buttons = { "Cancel", "OK" }
        love.window.showMessageBox("File conflict", message, buttons, "warning")
    end

    love.filesystem.createDirectory(folderName)
    local path = string.format("%s/%s/data.json", root, levelName)
    local file = love.filesystem.newFile(path, "w")
    file:write(filedata)
    file:close()
end
