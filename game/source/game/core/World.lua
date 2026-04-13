local World = {}

function World.newWorld()
    local Scene = entity()

    local objDraw = Scene._draw
    local objUpdate = Scene._update

    function Scene:_update(elapsed)
        if objUpdate then objUpdate(self, elapsed) end

        for _, child in ipairs(self.children) do
            if child.destroyed then
                self:remove(child)
            end
        end
    end

    return Scene
end

return World
