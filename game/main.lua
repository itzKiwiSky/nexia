require 'source.system.ErrHandler'
require 'source.system.Run'
local gitstuff = require 'source.system.GitStuff' -- super important stuff --
assetManager = require 'source.system.AssetManager'

languageService = {}
languageRaw = {}

function love.initialize()
    love.graphics.setDefaultFilter("nearest", "nearest")
    local languageManager = require 'source.system.utils.LanguageManager'

    local save = require 'source.system.utils.Save'

    gameSave = save.new("game")

    gameSave.save = {
        user = {
            leaderboard = {},
            settings = {},
        },
    }

    gameSave:initialize()
    love.keyboard.setTextInput(true)
    love.keyboard.setKeyRepeat(true)

    registers = {
        statesName = {},
        devWindow = false,
        devWindowContent = function() return end,
    }

    registers.devWindowContent = function()
        Slab.BeginWindow("menuNightDev", { Title = "Development" })
        for _, value in ipairs(registers.statesName) do
            if Slab.Button(value) then
                loadstring("gamestate.switch(" .. value .. ")")()
            end
        end
        Slab.EndWindow()
    end

    gitstuff() -- still super important --

    -- autoload states --
    local statePath = "source/states"
    local states = love.filesystem.getDirectoryItems(statePath)
    for s = 1, #states, 1 do
        if love.filesystem.getInfo(statePath .. "/" .. states[s]).type == "file" then
            require("source.states." .. states[s]:gsub(".lua", ""))
            local strName = states[s]:gsub(".lua", "")
            table.insert(registers.statesName, strName)
        end
    end

    --love.filesystem.createDirectory("mods")

    gamestate.registerEvents()

    assetManager.targetState = PlayState
    assetManager.init(require('load'))
end

function love.quit()
    --DitherManager.release()
end