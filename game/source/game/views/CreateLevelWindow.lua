package.loaded["source.game.views.Shared"] = nil
local shared = require("source.game.views.Shared")
local Song = require 'source.game.Song'

local function createLabeledInput(new, elements, grid, fonts, inputType, labelText, yPos, key)
    local paddingText = 2
    local paddingInput = 10

    local label = new("text")
    label:SetFont(fonts.label)
    label:SetDefaultColor(1, 1, 1, 1)
    label:SetText(labelText)
    grid:AddItem(label, yPos, paddingText, "left")

    switch(inputType, {
        ["textinput"] = function()
            local input = new("textinput")
            input:SetSize(176, label:GetHeight())
            input:SetFont(fonts.input)
            input:SetText("")
            input:SetHover(true)
            input.Update = function(this, elapsed)
                if type(key) ~= "nil" then
                    if tonumber(this:GetValue()) ~= nil then
                        key = tonumber(this:GetValue())
                    else
                        key = this:GetValue()
                    end
                end
            end
            grid:AddItem(input, yPos, paddingInput, "left")
        end,
    })

    table.insert(elements, {
        text = label,
        input = input
    })
end

return function(new)
    local font = fontcache.getFont("arial", 20)
    local fontInput = fontcache.getFont("arial", 16)
    local elements = {}
    local tempSong = Song:new()

    local frame = new("frame")
    frame:SetSize(320, 480)
    frame:SetName("New Level")
    frame:ShowCloseButton(false)
    frame:Center()
    frame:SetAlwaysUpdate(true)
    frame.Update = function(this)
        frame:SetVisible(EditorState.registers.UIState.showCreateLevelWindow)
    end

    local gridSize = 14
    local grid = new("grid")
    grid:SetParent(frame)
    grid:SetCellSize(gridSize, gridSize)
    grid:SetRows(math.floor(frame.height / gridSize) - 1)
    grid:SetColumns(math.floor(frame.width / gridSize) - 1)
    grid:SetCellPadding(0)
    grid:SetY(29)
    grid:SetVisible(false)
    grid.drawfunc = shared.blank

    local fonts = {
        label = font,
        input = fontInput
    }

    createLabeledInput(new, elements, grid, fonts, "textinput", "Song title", 2, tempSong.meta.title)
    createLabeledInput(new, elements, grid, fonts, "textinput", "Artist", 5, tempSong.meta.artist)
    createLabeledInput(new, elements, grid, fonts, "textinput", "BPM", 8, tempSong.meta.bpm)
    createLabeledInput(new, elements, grid, fonts, "textinput", "Description", 11, tempSong.meta.description)
    createLabeledInput(new, elements, grid, fonts, "textinput", "Tags", 14, tempSong.meta.tags)
    createLabeledInput(new, elements, grid, fonts, "textinput", "Charter", 17, tempSong.meta.mapper)

    local buttonConfirm = new("button")
    buttonConfirm:SetText("Create")
    buttonConfirm:SetSize(64, 28)
    buttonConfirm:SetHover(true)
    buttonConfirm.OnClick = function(this)
        EditorState.registers.UIState.showCreateLevelWindow = false
        table.deepmerge(EditorState.song, tempSong)
    end
    grid:AddItem(buttonConfirm, 31, 18, "left")

    local buttonCancel = new("button")
    buttonCancel:SetText("Cancel")
    buttonCancel:SetSize(64, 28)
    buttonCancel:SetHover(true)
    buttonCancel.OnClick = function(this)
        EditorState.registers.UIState.showCreateLevelWindow = false
    end
    grid:AddItem(buttonCancel, 31, 2, "left")
end
