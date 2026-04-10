require 'source.system.ErrHandler'
require 'source.system.Run'
local gitstuff = require 'source.system.GitStuff' -- super important stuff --
assetManager = require 'source.system.AssetManager'
require('source.system.Imports')()

updatePresence = require 'source.system.UpdatePresence'

languageService = {}
languageRaw = {}

function discordrpc.ready(userId, username, discriminator, avatar)
    local str = string.format("{bgBrightBlue}{brightWhite}[Love.DiscordRPC]{reset}{brightWhite}: ready (%s, %s, %s, %s){reset}", userId,
        username, discriminator, avatar)
    io.printf(str)
end

function discordrpc.disconnected(errorCode, message)
    local str = string.format("{bgBrightBlue}{brightWhite}[Love.DiscordRPC]{reset}{brightRed}: disconnected (%s, %s){reset}", errorCode,
        message)
    io.printf(str)
end

function discordrpc.errored(errorCode, message)
    local str = string.format("{bgBrightBlue}{brightWhite}[Love.DiscordRPC]{reset}{brightRed}: Error (%s, %s){reset}", errorCode, message)
    io.printf(str)
end

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
            local state = "source.states." .. states[s]:gsub(".lua", "")
            require(state)
            local strName = states[s]:gsub(".lua", "")
            local str = string.format(
                "{bgBrightMagenta}{brightCyan}{bold}[Love.AssetManager]{reset}{brightWhite} : State {bgYellow}%s{reset}{brightWhite} loaded with {brightGreen}Sucess{reset}",
                strName)
            io.printf(str)
            table.insert(registers.statesName, strName)
        end
    end

    --love.filesystem.createDirectory("mods")

    gamestate.registerEvents()

    assetManager.targetState = EditorState
    assetManager.init(require('load'))
end

function love.update(elapsed)
    discordrpc.runCallbacks()
end

function love.quit()
    discordrpc.shutdown()
end
