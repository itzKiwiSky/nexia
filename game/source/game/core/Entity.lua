local LOVE_EVENTS = {
    "untag",
    "draw",
    "update",
    "keypressed",
    "keyreleased",
    "mousepressed",
    "mousereleased",
    "wheelmoved",
    "mousemoved",
    "textinput",
    "focus",
    "visible",
    "resize",
    "show",
    "hide"
}

local function autobind(self)
    for _, ev in ipairs(LOVE_EVENTS) do
        self[ev] = function(self, ...)
            if self.destroyed then return end
            if self.paused and ev == "update" then return end
            if not self.visible and ev == "draw" then return end

            local fn = rawget(self, "_" .. ev)
            if fn then
                fn(self, ...)
            end

            for _, child in ipairs(self.children) do
                if child[ev] then
                    child[ev](child, ...)
                end
            end
        end
    end
end

-- util
local function wrap(old, new)
    if not old then return new end
    return function(self, ...)
        old(self, ...)
        new(self, ...)
    end
end

return function(c)
    local self = {}

    self.id = stid()
    self.visible = true
    self.paused = false
    self.parent = nil
    self.children = {}
    self.tags = {}
    self.destroyed = false

    self.components = {}

    autobind(self)

    -- ======================
    -- COMPONENT SYSTEM
    -- ======================

    function self:use(component)
        assert(component.id, "[Love.Entity.ComponentUse] : Component need an id")

        -- remove antigo
        if self.components[component.id] then
            --self:removeComponent(component.id)
            error("[Love.Entity] : Only supported one component with the same id at time")
        end

        self.components[component.id] = component

        for k, v in pairs(component) do
            if k ~= "id" then
                if type(v) == "function" and k:sub(1, 1) == "_" then
                    -- wrap eventos (_draw, _update, etc)
                    self[k] = wrap(self[k], v)
                elseif rawget(self, k) == nil then
                    -- dados simples (x, y, etc)
                    self[k] = v
                end
            end
        end

        if component.onAttach then
            component.onAttach(self)
        end
    end

    function self:removeComponent(id)
        local comp = self.components[id]
        if not comp then return end

        if comp.onDetach then
            comp.onDetach(self)
        end

        self.components[id] = nil
    end

    function self:getComponent(id)
        return self.components[id]
    end

    -- instantiate components and tags --
    if type(c) ~= "nil" then
        for _, item in ipairs(c) do
            if type(item) == "string" then
                table.insert(self.tags, item)
            elseif type(item) == "function" then
                self:use(item)
            end
        end
    end

    -- ======================
    -- HIERARQUIA
    -- ======================

    function self:add(obj)
        obj.parent = self
        table.insert(self.children, obj)
    end

    function self:remove(obj)
        for i, child in ipairs(self.children) do
            if child == obj then
                table.remove(self.children, i)
                return
            end
        end
    end

    function self:getByTag(tag)
        for i, child in ipairs(self.children) do
            if child == obj then
                table.remove(self.children, i)
                return
            end
        end
    end

    function self:destroy()
        self.destroyed = true
    end

    return self
end
