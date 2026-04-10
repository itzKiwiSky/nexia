local EditorTimeline = {}

local Conductor = require 'source.game.Conductor'
EditorTimeline.timelineX = 100
EditorTimeline.pixelsPerBeat = 80

function EditorTimeline.timeToX(time)
    local beatLength = 60 / Conductor.bpm
    return EditorTimeline.timelineX + (time / beatLength) * EditorTimeline.pixelsPerBeat
end

function EditorTimeline.xToTime(x)
    local beatLength = 60 / Conductor.bpm
    return ((x - EditorTimeline.timelineX) / EditorTimeline.pixelsPerBeat) * beatLength
end

return EditorTimeline
