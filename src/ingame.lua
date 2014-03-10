inGame = {}


---------------------------------------------------------------------------------------------------


function inGame:initialize()
end


---------------------------------------------------------------------------------------------------


function inGame:enter()
    self.exitRequested = false
    score = 0

    Obstacle.currentNumber = 0
    obstacles:reset()
end


---------------------------------------------------------------------------------------------------


function inGame:leave()
end


---------------------------------------------------------------------------------------------------


function inGame:keypressed(key)
    if key == "escape" then
        self.exitRequested = true
    end
end


---------------------------------------------------------------------------------------------------


function inGame:mousepressed(x, y, button)
    trampoline:setPosition(x, y)
end


---------------------------------------------------------------------------------------------------


function inGame:mousereleased(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inGame:update(dt)
    if self.exitRequested then
        return inTitle
    end

    clouds:update(dt)
    mountains:update(dt)
    mountainsBack:update(dt)

    acrobat:update(dt)
    trail:update(dt)
    trampoline:update(dt)

    obstacles:update(dt)
    for _,obstacle in ipairs(obstacles.ring) do
        if not obstacle.isPassed and acrobat.x - acrobat.radius > obstacle.x + obstacle.width then
            obstacle.isPassed = true
            score = score + 1
        end
    end
    return physics:update(dt)
end


---------------------------------------------------------------------------------------------------


function inGame:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(skyImage, skyQuad, 0, 0)
    clouds:draw()
    mountains:draw()
    mountainsBack:draw()

    trail:draw()

    acrobat:draw()
    trampoline:draw()
    obstacles:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>