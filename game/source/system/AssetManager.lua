local loveloader = require 'source.system.utils.LoveLoader'
local AssetManager = {}

AssetManager.mods = {}
AssetManager.targetState = nil
AssetManager.defaultLoadState = nil

---@enum AssetType
AssetManager.AssetType = {
    IMAGE = "images",
    AUDIO = "audios",
    DATA = "data",
}

local function newPool()
    return {
        images = {},
        audios = {
            static = {},
            stream = {},
        },
        fonts = {
            paths = {},
            pool = {},
        },
        shaders = {},
        data = {}
    }
end

AssetManager.assets = {
    ["builtin"] = newPool()
}

local LoadingState = {}

local icon

function LoadingState:enter()
    LoadingState.percentage = 0
    local mainFontPath = "assets/fonts"
    local paths = love.filesystem.getDirectoryItems("assets/fonts")
    icon = love.graphics.newImage("icon.png")

    for f = 1, #paths, 1 do
        assetManager.assets["builtin"].fonts.paths = string.format("%s/%s", mainFontPath, paths[f])
    end

    loveloader.start(function()
        gamestate.switch(assetManager.targetState)
    end, function(k, h, k)
        if FEATURE_FLAGS.debug then
            io.printf(string.format(
                "{bgBrightMagenta}{brightCyan}{bold}[LOVE]{reset}{brightWhite} : File loaded with {brightGreen}sucess{reset} | {bold}{underline}{brightYellow}%s{reset}",
                k))
        end
    end)
end

function LoadingState:draw()
    local width = 0
    love.graphics.draw(icon,
        shove.getViewportWidth() * 0.5, shove.getViewportHeight() * 0.5 - 150,
        0, 0.5, 0.5,
        icon:getWidth() * 0.5, icon:getHeight() * 0.5
    )

    local percentage = math.floor(shove.getViewportWidth() - 64 * (LoadingState.percentage / 100))
    width = math.lerp(width, percentage, 0.078)
    love.graphics.rectangle("line", 32, shove.getViewportHeight() - 48, shove.getViewportWidth() - 64, 32)

    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", 32, shove.getViewportHeight() - 48, width, 32)
    love.graphics.setLineWidth(1)
end

function LoadingState:update(elapsed)
    if loveloader.resourceCount > 0 then LoadingState.percentage = loveloader.loadedCount / loveloader.resourceCount end

    loveloader.update()
end

function LoadingState:leave(elapsed)
    icon:release()
end

---prepare a asset to be loaded
---@param kind AssetType
---@param key any
function AssetManager.load(kind, key, ...)
    --loveloader.newImage
    local p = string.split(key, ":")
    local namespace, assetKey = p[1], p[2]

    if namespace == nil then
        namespace = "builtin"
    end

    if kind == AssetManager.AssetType.IMAGE then
        local args = { ... }
        local path = args[1]
        loveloader.newImage(AssetManager.assets[namespace].images, assetKey, path)
    elseif kind == AssetManager.AssetType.AUDIO then
        local args = { ... }
        local path = args[1]
        local audioType = args[2] or "static"
        loveloader.newSource(AssetManager.assets[namespace].audios[audioType], assetKey, path, audioType)
    elseif kind == AssetManager.AssetType.DATA then
        local args = { ... }
        local path = args[1]
        loveloader.read(AssetManager.assets[namespace].data, assetKey, path)
    end
end

function AssetManager.init(def)
    love.filesystem.createDirectory("mods")

    def(AssetManager)
    if AssetManager.defaultLoadState == nil then
        gamestate.switch(LoadingState)
    else
        gamestate.switch(AssetManager.defaultLoadState)
    end
end

function AssetManager.onComplete()

end

function AssetManager.getAsset(key, kind, ...)

end

function AssetManager.release()

end

return AssetManager
