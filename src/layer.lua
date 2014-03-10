Layer = {}
Layer.__index = Layer


---------------------------------------------------------------------------------------------------


function Layer:new(size, itemClass, startX)
    local o = {}
    setmetatable(o, self)

    o.itemClass = itemClass
    o.startX = startX

    -- Content is stored in a ring buffer
    -- that is always full.
    o.ring = {}
    o.size = size
    o.first = 1
    local x = startX
    for i = 1, size do
        o.ring[i] = itemClass:new(x)
        x = x + itemClass.stride
    end

    return o
end


---------------------------------------------------------------------------------------------------


function Layer:reset()
    self.first = 1
    local x = self.startX
    for i = 1, self.size do
        self.ring[i]:reset(x)
        x = x + self.itemClass.stride
    end
end


---------------------------------------------------------------------------------------------------


function Layer:update(dt)
    local dx = self.speed * dt
    for i = self.first, #self.ring do
        self.ring[i]:move(dx)
    end
    for i = 1, self.first - 1 do
        self.ring[i]:move(dx)
    end

    -- Remove any item that has left the screen
    while self.ring[self.first].layerX + self.itemClass.stride < 0 do
        local last = self.first - 1
        if last < 1 then
            last = self.size
        end
        --self.ring[self.first] = self.itemClass:new(self.ring[last].layerX + self.itemClass.stride)
        self.ring[self.first]:reset(self.ring[last].layerX + self.itemClass.stride)
        self.first = (self.first + 1)
        if self.first > self.size then
            self.first = 1
        end
    end
end


---------------------------------------------------------------------------------------------------


function Layer:draw()
    for i = self.first, #self.ring do
        self.ring[i]:draw()
    end
    for i = 1, self.first - 1 do
        self.ring[i]:draw()
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>