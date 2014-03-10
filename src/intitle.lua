inTitle = {}


---------------------------------------------------------------------------------------------------


function inTitle:initialize()
    self.title = love.graphics.newImage("data/title.png")
    self.quitButton = Button:new(
            function ()
                love.event.push("quit")
            end,
            "data/quit.png",
            16,
            16,
            {255, 255, 255, 96}
        )
    self.fullscreenButton = Button:new(
            function ()
                love.window.setFullscreen(not love.window.getFullscreen())
                if love.window.getFullscreen() then
                    self.fullscreenButton:setIcon("data/window.png")
                else
                    self.fullscreenButton:setIcon("data/fullscreen.png")
                end
            end,
            "data/fullscreen.png",
            16 + 48 + 16, -- Real position set in 'love.resize' in "main.lua"
            16,
            {255, 255, 255, 96}
        )
    self.soundButton = Button:new(
            function ()
                if love.audio.getVolume() == 0 then
                    love.audio.setVolume(1)
                    self.soundButton:setIcon("data/sound.png")
                else
                    love.audio.setVolume(0)
                    self.soundButton:setIcon("data/silent.png")
                end
            end,
            "data/sound.png",
            16 + 48 + 16, -- Real position set in 'love.resize' in "main.lua"
            16,
            {255, 255, 255, 96}
        )
    self.playButton = Button:new(
            function ()
                self.startRequested = true
            end,
            "data/play.png",
            512, -- Real position set in 'love.resize' in "main.lua"
            512,
            {255, 255, 255, 255}
        )
end


---------------------------------------------------------------------------------------------------


function inTitle:enter()
    self.startRequested = false
end


---------------------------------------------------------------------------------------------------


function inTitle:leave()
end


---------------------------------------------------------------------------------------------------


function inTitle:keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end


---------------------------------------------------------------------------------------------------


function inTitle:mousepressed(x, y, button)
    self.quitButton:mousepressed(x, y, button) 
    self.fullscreenButton:mousepressed(x, y, button)
    self.soundButton:mousepressed(x, y, button)
    self.playButton:mousepressed(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inTitle:mousereleased(x, y, button)
    self.quitButton:mousereleased(x, y, button) 
    self.fullscreenButton:mousereleased(x, y, button)
    self.soundButton:mousereleased(x, y, button)
    self.playButton:mousereleased(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inTitle:update(dt)
    clouds:update(dt)
    mountains:update(dt)
    mountainsBack:update(dt)

    self.quitButton:update(dt)
    self.fullscreenButton:update(dt)
    self.soundButton:update(dt)
    self.playButton:update(dt)

    if self.startRequested then
        return inStart
    else
        return false
    end         
end


---------------------------------------------------------------------------------------------------


function inTitle:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(skyImage, skyQuad, 0, 0)
    clouds:draw()
    mountains:draw()
    mountainsBack:draw()

    local titleWidth = self.title:getWidth()
    local titleScale = 1
    if titleWidth + 2*48 + 64 > virtualWidth then
        titleScale = virtualWidth / (titleWidth + 2*48 + 64)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.title, virtualWidth/2 - titleScale*titleWidth/2, 48+16, 0, titleScale, titleScale)

    love.graphics.setColor(30, 30, 30, 128)
    love.graphics.setFont(clickFont)
    local text1 = "a Flappy Bird fan game"
    love.graphics.print(text1, virtualWidth/2 - clickFont:getWidth(text1)/2, 48+16 + self.title:getHeight() + 0)
    love.graphics.setFont(smallFont)
    local text2 = "by drakmaniso"
    love.graphics.print(text2, virtualWidth/2 - smallFont:getWidth(text2)/2, 48+16 + self.title:getHeight() + 0 + clickFont:getHeight(text1) + 16)

    -- love.graphics.setFont(scoreFont)
    -- love.graphics.setColor(255, 255, 255)
    -- local text3 = "Click to Start!"
    -- love.graphics.print(text3, virtualWidth/2 - scoreFont:getWidth(text3)/2, 48+16 + self.title:getHeight() + 0 + 2*clickFont:getHeight(text1) + 96)

    if highScore > 0 then
        love.graphics.setFont(clickFont)
        local text4 = "High Score: " .. highScore
        love.graphics.setColor(30, 30, 30, 128)
        love.graphics.print(text4, virtualWidth/2 - clickFont:getWidth(text4)/2, virtualHeight - clickFont:getHeight(text4) - 16)
    end

    self.quitButton:draw()
    self.fullscreenButton:draw()
    self.soundButton:draw()
    self.playButton:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>