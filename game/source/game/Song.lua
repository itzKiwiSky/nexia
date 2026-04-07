local Song = class:extend("Song")

function Song:__construct()
    self.meta = {
        bpm = 100,
        songStartOffset = 0,
        title = "",
        artist = "",
        mapper = "",
        description = "",
        flags = {
            scriptedEvents = false
        },
        tags = {},
    }

    self.lanes = {}

    self.events = {}
end

function Song:update(elapsed)

end

function Song:loadFile(filename)

end

return Song
