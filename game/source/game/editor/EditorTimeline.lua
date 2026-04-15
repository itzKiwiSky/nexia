local EditorTimeline = {}

local Conductor = require 'source.game.Conductor'
EditorTimeline.timelineX = 100
EditorTimeline.pixelsPerBeat = 80
EditorTimeline.lanes = {}

function EditorTimeline.timeToX(time)
    local beatLength = 60 / Conductor.bpm
    return EditorTimeline.timelineX + (time / beatLength) * EditorTimeline.pixelsPerBeat
end

function EditorTimeline.xToTime(x)
    local beatLength = 60 / Conductor.bpm
    return ((x - EditorTimeline.timelineX) / EditorTimeline.pixelsPerBeat) * beatLength
end

function EditorTimeline:snapTime(time)
    local beatLength = 60 / Conductor.bpm
    local snap = beatLength / self.beatSubdivision

    return math.floor(time / snap + 0.5) * snap
end

function EditorTimeline:clear()
    table.clear(self.lanes)
end

function EditorTimeline:addLane(lane)
    table.insert(self.lanes, lane)
end

function EditorTimeline:draw()
    for _, lane in ipairs(self.lanes) do
        lane:draw(self)
    end
end

function EditorTimeline:mousepressed(button, x, y)
    for _, lane in ipairs(self.lanes) do
        lane:mousepressed(self, x, y, button)
    end
end

return EditorTimeline
