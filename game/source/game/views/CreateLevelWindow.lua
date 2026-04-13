return function(new)
    local font = fontcache.getFont("arial", 20)

    local frame = new("frame")
    frame:SetSize(320, 480)
    frame:SetName("New Level")
    frame:ShowCloseButton(false)
    frame:Center()

    local gridSize = 16
    local grid = new("grid")
    grid:SetParent(frame)
    grid:SetCellSize(gridSize, gridSize)
    grid:SetRows(math.floor(frame.height / gridSize) - 1)
    grid:SetColumns(math.floor(frame.width / gridSize) - 1)
    grid:SetCellPadding(0)
    grid:SetY(29)

    local l_songName = new("text")
    l_songName:SetFont(font)
    l_songName:SetDefaultColor(1, 1, 1, 1)
    l_songName:SetText("Song name")
    grid:AddItem(l_songName, 2, 2, "left")

    local ti_songName = new("textinput")
    ti_songName:SetSize(160, l_songName:GetHeight())
    ti_songName:SetFont(font)
    ti_songName:SetText("")
    ti_songName:SetHover(true)
    grid:AddItem(ti_songName, 2, 10, "left")
end
