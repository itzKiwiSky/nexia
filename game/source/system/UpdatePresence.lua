local Presence = {
    state = "Initializing...",
    details = "Getting everything done",
    largeImageKey = "icon",
    largeImageText = "Playing Neonix!",

}

setmetatable(Presence, {
    __call = function()
        discordrpc.updatePresence(Presence)
        local str = "{bgBrightBlue}{brightWhite}[Love.DiscordRPC]{reset}{brightBlue}: updated presence{reset}"
        io.printf(str)
    end
})


return Presence
