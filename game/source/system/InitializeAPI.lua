return function()
    local configAPI = json.decode(love.filesystem.read("API.json"))

    discordrpc.initialize(configAPI.discord.appID, true)
end
