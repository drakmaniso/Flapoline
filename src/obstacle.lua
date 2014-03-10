Obstacle = {}
Obstacle.__index = Obstacle


---------------------------------------------------------------------------------------------------


function Obstacle:initialize()
    self.image = love.graphics.newImage("data/obstacle.png")
    self.currentNumber = 0
end


---------------------------------------------------------------------------------------------------


function Obstacle:new(x)
    local object = {}
    setmetatable(object, self)
    object:reset(x)
    return object
end


---------------------------------------------------------------------------------------------------


function Obstacle:reset(x)
    self.isPassed = false

    Obstacle.currentNumber = Obstacle.currentNumber + 1
    self.number = Obstacle.currentNumber
    self.layerX = x
    self.x = x
    self.apertureY = math.random(Obstacle.apertureUpperLimit, virtualHeight - Obstacle.apertureLowerLimit)
    self.apertureY = math.modf(self.apertureY / 64) * 64

    self.upper = 
    { 
        x = self.x, 
        y = -240,                                  
        width = self.width, 
        height = 240 + self.apertureY - self.apertureHeight / 2
    }
    self.lower = 
    { 
        x = self.x, 
        y = self.apertureY + self.apertureHeight / 2, 
        width = self.width, 
        height = virtualHeight
    }
end


---------------------------------------------------------------------------------------------------


function Obstacle:move(dx)
    self.layerX = self.layerX - dx
    self.x = self.x - dx
    self.upper.x = self.upper.x - dx
    self.lower.x = self.lower.x - dx
end


---------------------------------------------------------------------------------------------------


function Obstacle:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.image, self.upper.x - 5, self.upper.y + self.upper.height + 2 - self.image:getHeight())
    love.graphics.draw(self.image, self.lower.x - 5, self.lower.y - 2)

    local scoreText = "" .. self.number
    love.graphics.setColor(30, 30, 30, 128)
    love.graphics.setFont(scoreFont)
    love.graphics.print(scoreText, self.lower.x + self.lower.width + 8, virtualHeight - scoreFont:getHeight())
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>