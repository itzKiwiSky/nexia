local EditorTimeline = {}

local Conductor = require 'source.game.Conductor'
EditorTimeline.timelineX = 100
EditorTimeline.pixelsPerBeat = 80
EditorTimeline.beatSubdivision = 4
EditorTimeline.lanes = {}

function EditorTimeline.timeToX(time)
    local beatLength = 60 / Conductor.bpm
    return EditorTimeline.timelineX + (time / beatLength) * EditorTimeline.pixelsPerBeat
end

function EditorTimeline.xToTime(x)
    local beatLength = 60 / Conductor.bpm
    return ((x - EditorTimeline.timelineX) / EditorTimeline.pixelsPerBeat) * beatLength
end

function EditorTimeline:snapTime(time)
    local beatLength = 60 / Conductor.bpm
    local snap = beatLength / self.beatSubdivision

    return math.floor(time / snap + 0.5) * snap
end

function EditorTimeline:clear()
    table.clear(self.lanes)
end

function EditorTimeline:addLane(lane)
    table.insert(self.lanes, lane)
end

function EditorTimeline:draw(startY)
    for _, lane in ipairs(self.lanes) do
        lane:draw(self)
    end
end

function EditorTimeline:update(elapsed)
    self:centerLanesInY()
end

function EditorTimeline:centerLanesInY()
    local laneHeight = 32
    local viewportHeight = love.graphics.getHeight()
    local totalHeight = #self.lanes * laneHeight

    -- Calcula o offset Y para centralizar o grupo de lanes
    local offsetY = (viewportHeight - totalHeight) / 2

    -- Aplica a posição Y para cada lane
    for index, lane in ipairs(self.lanes) do
        lane.y = offsetY + (index - 1) * laneHeight
    end
end

function EditorTimeline:mousepressed(button, x, y)
    for _, lane in ipairs(self.lanes) do
        lane:mousepressed(self, x, y, button)
    end
end

function EditorTimeline:wheelmoved(x, y)
    -- Sensibilidade: quanto de tempo (ms) cada unidade de scroll representa
    local scrollSensitivity = 100 -- ms por unidade de scroll

    -- Verifica se Ctrl está pressionado para scroll rápido (5x)
    local speedMultiplier = 1
    if love.keyboard.isDown('lctrl', 'rctrl') then
        speedMultiplier = 5
    end

    -- Calcula o delta de tempo: y positivo = scroll up (avança), negativo = scroll down (retrocede)
    local timeDelta = y * scrollSensitivity * speedMultiplier

    -- Modifica a posição da música
    Conductor.songPos = Conductor.songPos + timeDelta

    -- Proteção: não deixar a posição ficar negativa
    if Conductor.songPos < 0 then
        Conductor.songPos = 0
    end
end

return EditorTimeline
