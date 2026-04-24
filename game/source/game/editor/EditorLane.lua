local EditorLane = class:extend("EditorLane")
local timeline = require 'source.game.editor.EditorTimeline'

function EditorLane:__construct()
    self.y = 0
    self.height = 32
    self.notes = {}
end

function EditorLane:containsPoint(x, y)
    return x >= 0
        and x <= shove.getViewportWidth()
        and y >= self.y
        and y <= self.y + self.height
end

function EditorLane:draw()
    local width = shove.getViewportWidth()
    local height = 32

    love.graphics.rectangle("line", 0, self.y, width, height)

    local subdivision = timeline.pixelsPerBeat / 4

    for x = timeline.timelineX, width, subdivision do
        love.graphics.line(x, self.y, x, self.y + height)
    end

    for _, note in ipairs(self.notes) do
        local noteX = timeline.timeToX(note.time)

        love.graphics.rectangle(
            "fill",
            noteX - 8,
            self.y + 4,
            16,
            self.height - 8
        )
    end
end

function EditorLane:mousepressed(timeline, x, y, button)
    if button ~= 1 then return end
    if not self:containsPoint(x, y) then return end

    local time = timeline.xToTime(x)
    time = timeline:snapTime(time)

    table.insert(self.notes, {
        time = time
    })
end

return EditorLane
