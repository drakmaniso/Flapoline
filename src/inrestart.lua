inRestart = {}
setmetatable(inRestart, {__index = inStart})


---------------------------------------------------------------------------------------------------


function inRestart:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(skyImage, skyQuad, 0, 0)
    clouds:draw()
    mountains:draw()
    mountainsBack:draw()

    self.backButton:draw()

    acrobat:draw()
    self:drawClickMessage()

    inGameOver:drawScores()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>