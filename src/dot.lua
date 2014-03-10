Dot = {}
Dot.__index = Dot


---------------------------------------------------------------------------------------------------


Dot.radius = 4
Dot.segments = 6


---------------------------------------------------------------------------------------------------


function Dot:new(x, y)
    object = { x = x, y = y, age = 0}
    setmetatable(object, self)
    return object
end


---------------------------------------------------------------------------------------------------


function Dot:move(dx)
    self.x = self.x - dx
    self.age = self.age + dx / 16
end


---------------------------------------------------------------------------------------------------


function Dot:draw()
    local alpha = math.max(0, 29 - self.age)
    love.graphics.setColor(10, 10, 10, alpha)
    love.graphics.circle("fill", self.x, self.y, Dot.radius, Dot.segments)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>