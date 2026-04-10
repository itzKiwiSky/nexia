EditorState = {}

local Conductor = require 'source.game.Conductor'

local EditorTimeline = require 'source.game.editor.EditorTimeline'

function EditorState:enter()
    loveframes.SetActiveSkin("Dark crimson")

    loveView.registerLoveframesEvents()

    loveView.unloadView()
    loveView.addView("source/game/views/EditorMenuBar.lua")
    loveView.addView("source/game/views/EditorTab.lua")
end

function EditorState:draw()
    loveView.draw()
end

function EditorState:update(elapsed)
    loveView.update(elapsed)
end

return EditorState
