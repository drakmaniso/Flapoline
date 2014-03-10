Cloud = {}
Cloud.__index = Cloud


---------------------------------------------------------------------------------------------------


Cloud.stride = 640


---------------------------------------------------------------------------------------------------


function Cloud:initialize()
    self.images = {}
    for i = 1, 3 do
        self.images[i] = love.graphics.newImage("data/cloud" .. i ..".png")
    end
    self.shuffleBag = ShuffleBag:new(3)
end


---------------------------------------------------------------------------------------------------


function Cloud:new(x)
    local object = {}
    setmetatable(object, self)
    object:reset(x)
    return object
end


---------------------------------------------------------------------------------------------------


function Cloud:reset(x)
    self.image = Cloud.images[Cloud.shuffleBag:next()]
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.layerX = x
    self.x = x + math.random(0, Cloud.stride - self.width)
    self.y = math.random(0, virtualHeight / 8)
end


---------------------------------------------------------------------------------------------------


function Cloud:move(dx)
    self.x = self.x - dx
    self.layerX = self.layerX - dx
end


---------------------------------------------------------------------------------------------------


function Cloud:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.x, self.y)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>