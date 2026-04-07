EditorState = {}

local Conductor = require 'source.game.Conductor'

local EditorTimeline = {
    timelineX = 100,
    pixelsPerBeat = 80
}

function EditorTimeline.timeToX(time)
    local beatLength = 60 / Conductor.bpm
    return EditorTimeline.timelineX + (time / beatLength) * EditorTimeline.pixelsPerBeat
end

function EditorTimeline.xToTime(x)
    local beatLength = 60 / Conductor.bpm
    return ((x - EditorTimeline.timelineX) / EditorTimeline.pixelsPerBeat) * beatLength
end

function EditorState:enter()
    loveframes.SetActiveSkin("Dark crimson")

    loveView.registerLoveframesEvents()

    loveView.unloadView()
    loveView.addView("source/game/views/EditorMenuBar.lua")
    loveView.addView("source/game/views/EditorTab.lua")
    --loveView.addView("")
end

function EditorState:draw()
    loveView.draw()
end

function EditorState:update(elapsed)
    loveView.update(elapsed)
end

return EditorState
