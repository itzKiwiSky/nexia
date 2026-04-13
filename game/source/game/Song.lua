local Song = class:extend("Song")

local Conductor = require 'source.game.Conductor'

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

function Song:update()
    Conductor.update()
end

function Song:loadFile(filename)
    -- do shit --
end

return Song
