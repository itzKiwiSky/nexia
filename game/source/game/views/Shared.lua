return {
    blank = function() end,
    buttonHitbox = function(obj)
        local skin   = obj:GetSkin()
        local x      = obj:GetX()
        local y      = obj:GetY()
        local width  = obj:GetWidth()
        local height = obj:GetHeight()
        local hover  = obj:GetHover()

        local top    = hover and skin.controls.color_active or { 0, 0, 0, 0 }

        love.graphics.setColor(top)
        love.graphics.rectangle("fill", x, y, width, height)
        love.graphics.setColor(1, 1, 1, 1)
    end,
    filesytemDialog = require 'source.game.editor.FilesystemDialog',
}
