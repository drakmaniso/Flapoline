Mountain = {}
Mountain.__index = Mountain


---------------------------------------------------------------------------------------------------


Mountain.stride = 1024


---------------------------------------------------------------------------------------------------


function Mountain:initialize()
    self.images = {}
    for i = 1, 3 do
        self.images[i] = love.graphics.newImage("data/mountain" .. i ..".png")
    end
    self.shuffleBag = ShuffleBag:new(3)
end


---------------------------------------------------------------------------------------------------


function Mountain:new(x)
    local object = {}
    setmetatable(object, self)
    object:reset(x)
    return object
end


---------------------------------------------------------------------------------------------------


function Mountain:reset(x)
    self.image = Mountain.images[Mountain.shuffleBag:next()]
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.layerX = x
    self.x = x + math.random(0, Mountain.stride - self.width)
    self.y = virtualHeight - self.height
end


---------------------------------------------------------------------------------------------------


function Mountain:move(dx)
    self.x = self.x - dx
    self.layerX = self.layerX - dx
end


---------------------------------------------------------------------------------------------------


function Mountain:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.x, self.y)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>