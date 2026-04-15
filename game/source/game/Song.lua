local MusicObject = require 'source.game.MusicObject'
local Song = MusicObject:extend("Song")

local Conductor = require 'source.game.Conductor'

local NoteData = class:extend("NoteData")

function NoteData:__construct(time, sustainTime, isSustain)
    self.time = time
    self.sustainTime = sustainTime
    self.isSustain = isSustain
end

function Song:__construct()
    self.meta = {
        bpm = 100,
        songStartOffset = 0,
        title = "",
        artist = "",
        mapper = "",
        description = "",
        laneCount = 1,
        flags = {
            scriptedEvents = false
        },
        tags = "",
    }

    self.lanes = {}

    self.events = {}
end

function Song:clone()
    local s = Song:new()
    s.meta = self.meta
    s.lanes = self.lanes
    s.events = {}
    return s
end

function Song:getRepresentation()
    return {
        meta = self.meta,
        lanes = self.lanes,
        events = self.events,
    }
end

function Song:draw()
    if love.FEATURE_FLAGS.developerMode then
        love.graphics.print(inspect(self), 20, 20)
    end
end

function Song:update()
    Conductor.update()
end

function Song:loadFile(filename)
    -- do shit --
end

return Song
