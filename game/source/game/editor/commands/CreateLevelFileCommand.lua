local function transformText(text)
    local txt = text:gsub(" ", "_")
    txt = txt:lower()
    return txt
end

local function create(root, folderName, levelName, filedata)
    love.filesystem.createDirectory(folderName)
    local path = string.format("%s/%s/data.json", root, levelName)
    local file = love.filesystem.newFile(path, "w")
    file:write(filedata)
    file:close()
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
        local button = love.window.showMessageBox("File conflict", message, buttons, "warning")


        if button > 0 then
            local option = buttons[button]
            if option == "OK" then
                create(root, folderName, levelName, filedata)
            end
        end
    else
        create(root, folderName, levelName, filedata)
    end
end
