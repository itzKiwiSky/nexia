local Lane = class:extend("Lane")

function Lane:__construct(control)
    self.control = control
    self.notes = {}
    self.scrollSpeed = 1.7
    self.renderedNotes = {}
    self.x = 0
    self.y = 0
    self.opacity = 1
    self.showLines = true
    self.rotation = 0
end

function Lane:draw()
    for _, note in ipairs(self.renderedNotes) do
        if type(note.draw) ~= "nil" then
            note:draw()
        end
    end
end

function Lane:update()
    for _, note in ipairs(self.renderedNotes) do
        if type(note.update) ~= "nil" then
            note:update(elapsed)
        end
    end
end

return Lane
