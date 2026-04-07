package.loaded["source.game.views.Shared"] = nil
local shared = require 'source.game.views.Shared'

local function newTabItem(name, action)
    return {
        name = name,
        action = action
    }
end

local function newTab(name, items)
    return {
        name = name,
        items = items or {}
    }
end

return function(new)
    local tabs = {}

    local padding = 20
    local options = {
        newTab("File", {
            newTabItem("New project", function()

            end),
        }),
        newTab("Edit", {
        }),
        newTab("View", {

        }),
    }

    local font = fontcache.getFont("pixel_font", 18)

    local panel = new("panel")
    panel:SetSize(shove.getViewportWidth(), 26)

    --local btn = new("button")

    for idx, tab in ipairs(options) do
        local btn = new("button")
        btn.drawfunc = shared.buttonHitbox
        btn.x = (btn.width + padding) * (idx - 1)
        btn:SetHeight(panel.height)
        btn:SetHover(true)
        btn.OnClick = function(obj)
            -- make a tab manager later --
        end

        local txt = new("text")
        txt:SetDefaultColor(1, 1, 1, 1)
        txt:SetFont(font)
        txt:SetParent(btn)
        txt:SetText(tab.name)
        txt:SetX(btn.x)

        txt:CenterWithinArea(btn.x, btn.y, btn.width, btn.height)
    end

    --btn.drawfunc = shared.blank
end
