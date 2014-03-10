inGameOver = {}


---------------------------------------------------------------------------------------------------


function inGameOver:initialize()
    self.bamImage = love.graphics.newImage("data/bam.png")
    self.bamOX = self.bamImage:getWidth()/2
    self.bamOY = self.bamImage:getHeight()/2
    self.bamSound = love.audio.newSource("data/bam.wav")
    self.bamSound:setVolume(1.0)
end


---------------------------------------------------------------------------------------------------


function inGameOver:enter()
    self.bamSound:stop()
    self.bamSound:play()
    self.exitRequested = false
    self.timer = 0
    self.displayedScore = 0
    hasNewHighScore = score > highScore
    if hasNewHighScore then
        highScore = score
        save:open("w")
        save:write(highScore .. "\n")
        save:close()
    end
end


---------------------------------------------------------------------------------------------------


function inGameOver:leave()
end


---------------------------------------------------------------------------------------------------


function inGameOver:keypressed(key)
    if key == "escape" then
        self.exitRequested = true
    end
end


---------------------------------------------------------------------------------------------------


function inGameOver:mousepressed(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inGameOver:mousereleased(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inGameOver:update(dt)
    if self.exitRequested then
        return inTitle
    end

    trampoline:gameOverUpdate(dt)

    self.timer = self.timer + dt
    self.displayedScore = math.modf(self.timer * 20) + 1
    self.displayedScore = math.min(score, self.displayedScore)
   if self.timer > 1.5 and self.displayedScore == score then
        return inRestart
    else
        return false
    end
end


---------------------------------------------------------------------------------------------------


function inGameOver:drawScores()
    self.scoreY = 32
    self.scoreWidth = 512
    self.scoreHeight = 256

    local scoreText = "" .. self.displayedScore
    love.graphics.setColor(50, 50, 50)
    love.graphics.setFont(bigScoreFont)
    love.graphics.print(scoreText, virtualWidth/2 - bigScoreFont:getWidth(scoreText)/2, virtualHeight/2 - bigScoreFont:getHeight()/2)

    if hasNewHighScore then
        local highScoreText = "New High Score!"
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(139, 63, 188)
        love.graphics.setColor(111, 50, 150)
        love.graphics.print(highScoreText, virtualWidth/2 - scoreFont:getWidth(highScoreText)/2, virtualHeight/2 - bigScoreFont:getHeight()/2 - 16 - scoreFont:getHeight())
    else
        local highScoreText = "High Score: " .. highScore .. ""
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(30, 30, 30, 128)
        love.graphics.print(highScoreText, virtualWidth/2 - scoreFont:getWidth(highScoreText)/2, virtualHeight/2 + bigScoreFont:getHeight()/2 + 16)
    end
end


---------------------------------------------------------------------------------------------------


function inGameOver:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(skyImage, skyQuad, 0, 0)
    clouds:draw()
    mountains:draw()
    mountainsBack:draw()

    trail:draw()

    trampoline:draw()
    obstacles:draw()

    love.graphics.setColor(255, 255, 255)
    local zoom = 1
    if self.timer < 0.03 then
        zoom = self.timer / 0.03
    elseif self.timer < 0.08 then
        zoom = 1 + (self.timer - 0.03) / 0.10
    elseif self.timer < 0.13 then
        zoom = 1 + (0.13 - self.timer) / 0.10
    end
    love.graphics.draw(self.bamImage, self.collisionX, self.collisionY, 0, zoom, zoom, self.bamOX, self.bamOY)

    inGameOver:drawScores()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>