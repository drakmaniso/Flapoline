trail = {}


---------------------------------------------------------------------------------------------------


function trail:initialize()
    self.size = 24
    self.ring = {}
    self.first = 1
    for i = 1, self.size do
        self.ring[i] = Dot:new(128 + 64 * i, virtualHeight + 512)
    end
end


---------------------------------------------------------------------------------------------------


function trail:placeDot(x, y)
    local last = self.first - 1
    if last < 1 then
        last = self.size
    end
    self.ring[last].x = x
    self.ring[last].y = y
    self.ring[last].age = 0
    self.first = self.first + 1
    if self.first > self.size then
        self.first = 1
    end
end


---------------------------------------------------------------------------------------------------


function trail:update(dt)
    for _,dot in ipairs(self.ring) do
        dot:move(self.speed * dt)
    end
end


---------------------------------------------------------------------------------------------------


function trail:draw()
    for _,dot in ipairs(self.ring) do
        dot:draw()
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>