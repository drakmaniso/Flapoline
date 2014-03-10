ShuffleBag = {}
ShuffleBag.__index = ShuffleBag


---------------------------------------------------------------------------------------------------


function ShuffleBag:new(n)
    local object = {}
    setmetatable(object, self)

    object.bag = {}
    for i=1,n do
        object.bag[i] = i
    end

    object.current = #object.bag

    return object
end


---------------------------------------------------------------------------------------------------


function ShuffleBag:next()
    if self.current < 2 then
        self.current = #self.bag
        return self.bag[1]
    end

    local position = math.random(1, self.current)
    local value = self.bag[position]
    self.bag[position] = self.bag[self.current]
    self.bag[self.current] = value

    self.current = self.current - 1

    return value
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>