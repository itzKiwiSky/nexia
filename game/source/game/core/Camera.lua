--- @class iris.core.Camera
local Camera = class:extend("Camera")

---Constructor
---@param x number
---@param y number
---@param zoom number
---@param rotation number
function Camera:__construct(x, y, zoom, rotation)
    self.x = x or shove.getViewportWidth * 0.5
    self.y = y or shove.getViewportHeight * 0.5
    self.zoom = zoom or 1
    self.rotation = rotation or 0
end

--- Reset the camera to a default state
function Camera:reset()
    self.x = shove.getViewportWidth * 0.5
    self.y = shove.getViewportHeight * 0.5
    self.zoom = 1
    self.rotation = 0
end

--- Attach camera to begin transformation
function Camera:start()
    local cx, cy = shove.getViewportWidth * 0.5, shove.getViewportHeight * 0.5
    love.graphics.push("all")
    love.graphics.translate(cx, cy)
    love.graphics.scale(self.zoom)
    love.graphics.rotate(math.rad(self.rotation))
    love.graphics.translate(-self.x, -self.y)
end

--- Detach camera to stop the effect transformation
function Camera:stop()
    love.graphics.pop()
end

-- wrap the functions to start and finish transformation --
function Camera:render(fn)
    self:start()
    fn()
    self:stop()
end

--- world coordinates to camera coordinates
---@param x number
---@param y number
function Camera:cameraCoords(x, y)
    local ox, oy = 0, 0
    local w, h = shove.getViewportWidth, shove.getViewportHeight

    local c, s = math.cos(self.rotation), math.sin(self.rotation)
    x, y = x - self.x, y - self.y
    x, y = c * x - s * y, s * x + c * y
    return x * self.zoom + w * 0.5 + ox, y * self.zoom + h * 0.5 + oy
end

---  camera coordinates to world coordinates
---@param x number
---@param y number
function Camera:worldCoords(x, y)
    local ox, oy = 0, 0
    local w, h = shove.getViewportWidth, shove.getViewportHeight

    local c, s = math.cos(-self.rotation), math.sin(-self.rotation)
    x, y = (x - w * 0.5 - ox) / self.zoom, (y - h * 0.5 - oy) / self.zoom
    x, y = c * x - s * y, s * x + c * y
    return x + self.x, y + self.y
end

--- Get mouse position based on camera transformation
--- @return number, number
function Camera:mousePosition()
    local inside, mx, my = shove.mouseToViewport()
    return self:worldCoords(mx, my)
end

--- Set camera zoom
---@param zoom number
function Camera:setZoom(zoom)
    self.zoom = zoom
    return self
end

--- Set camera rotation
---@param rotation number
function Camera:setRotation(rotation)
    self.rotation = rotation
    return self
end

--- Set camera position
---@param x number
---@param y number
function Camera:setCameraPosition(x, y)
    self.x, self.y = x, y
    return self
end

return Camera
