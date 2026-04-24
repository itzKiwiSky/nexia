EditorState = {}

local Conductor = require 'source.game.Conductor'
local EditorTimeline = require 'source.game.editor.EditorTimeline'
local Song = require 'source.game.Song'
local EditorLane = require 'source.game.editor.EditorLane'

function EditorState:enter()
    self.song = Song:new()

    loveframes.SetActiveSkin("Dark crimson")

    self.registers = {
        isLevelLoaded = false,
        isEditing = false,
        isUIShowing = true,
        UIState = {
            showCreateLevelWindow = false,
            showLaneEditorWindow = false,
        }
    }

    -- if not level loaded, open this window to create a new level --
    self.registers.UIState.showCreateLevelWindow = not self.registers.isLevelLoaded

    loveView.registerLoveframesEvents()

    local UIPaths = {
        "source/game/views/EditorMenuBar.lua",
        "source/game/views/EditorLane.lua",
        "source/game/views/CreateLevelWindow.lua"
    }

    EditorTimeline:clear() -- make sure all lanes are cleared before being created --

    loveView.unloadView()
    for idx, path in ipairs(UIPaths) do
        loveView.addView(path)
    end
end

function EditorState:updateState()
    -- we double clear just to make sure --
    EditorTimeline:clear()

    for idx = 1, self.song.meta.laneCount, 1 do
        local lane = EditorLane:new()
        EditorTimeline:addLane(lane)
    end
end

function EditorState:draw()
    loveView.draw()
    EditorTimeline:draw()
end

function EditorState:update(elapsed)
    loveView.update(elapsed)
    self.song:update(elapsed)
    EditorTimeline:update(elapsed)
end

function EditorState:mousepressed(x, y, button)
    EditorTimeline:mousepressed(button, x, y)
end

function EditorState:wheelmoved(x, y)
    EditorTimeline:wheelmoved(x, y)
end

function EditorState:leave()
    loveView.unloadView()
end

return EditorState
