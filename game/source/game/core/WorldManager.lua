---@class Scene
---@field objects table

local WorldManager = {}

WorldManager.scenes = {}
WorldManager.stack = {}
WorldManager.currentScene = nil

function WorldManager.switch(scene)
    WorldManager.currentScene = scene
    WorldManager.scenes[scene]()
end

---Create a new scene and push to stack
---@param sceneName string
---@param def function
function WorldManager.push(scene)
    WorldManager.scenes[sceneName] = def
end

function WorldManager.draw()

end

function WorldManager.update(elapsed)

end

return WorldManager
