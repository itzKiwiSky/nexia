local MusicObject = class:extend("MusicObject")

function MusicObject:__construct(time)
    self.time = time
    self.x = 0
    self.y = 0
    self.img = nil
    self.frame = 1
    self.frames = {}
    self.animations = {}
end

function MusicObject:draw()

end

function MusicObject:update(elapsed)

end

return MusicObject
