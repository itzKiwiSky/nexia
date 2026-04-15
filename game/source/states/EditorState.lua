EditorState = {}

local Conductor = require 'source.game.Conductor'

local EditorTimeline = require 'source.game.editor.EditorTimeline'

local Song = require 'source.game.Song'

local function updateUIState(state)

end

function EditorState:enter()
    self.song = Song:new()

    loveframes.SetActiveSkin("Dark crimson")

    self.registers = {
        isLevelLoaded = false,
        isEditing = false,
        isUIShowing = true,
        UIState = {
            showCreateLevelWindow = true
        }
    }

    loveView.registerLoveframesEvents()

    local UIPaths = {
        "source/game/views/EditorMenuBar.lua",
        "source/game/views/EditorTab.lua",
        "source/game/views/CreateLevelWindow.lua"
    }

    loveView.unloadView()
    for idx, path in ipairs(UIPaths) do
        loveView.addView(path)
    end
end

function EditorState:draw()
    loveView.draw()
end

function EditorState:update(elapsed)
    loveView.update(elapsed)
    self.song:update(elapsed)
end

function EditorState:leave()
    loveView.unloadView()
end

return EditorState
