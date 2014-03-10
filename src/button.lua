Button = {}
Button.__index = Button


---------------------------------------------------------------------------------------------------


function Button:new(action, imageName, x, y, color)
    local object = {}
    setmetatable(object, self)
    object:reset(action, imageName, x, y, color)
    return object
end


---------------------------------------------------------------------------------------------------


function Button:reset(action, imageName, x, y, color)
    self.action = action
    self.image = love.graphics.newImage(imageName)
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.isUnderMouse = false
    self.isPressed = false
    self.color = color
end


---------------------------------------------------------------------------------------------------


function Button:setIcon(imageName)
    self.image = love.graphics.newImage(imageName)
end


---------------------------------------------------------------------------------------------------


function Button:setPosition(x, y)
    self.x = x
    self.y = y
end


---------------------------------------------------------------------------------------------------


function Button:mousepressed(x, y, button)
    if self.isUnderMouse then
        self.isPressed = true
        return true
    end
    return false
end


---------------------------------------------------------------------------------------------------


function Button:mousereleased(x, y, button)
    if self.isUnderMouse and self.isPressed then
        self.isPressed = false
        self.action()
        return true
    end
    self.isPressed = false
    return false
end


---------------------------------------------------------------------------------------------------


function Button:update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX / virtualScale
    mouseY = mouseY / virtualScale
    if
        mouseX >= self.x and mouseX <= self.x + self.width
        and mouseY >= self.y and mouseY <= self.y + self.height
    then
        self.isUnderMouse = true
    else
        self.isUnderMouse = false
    end
end


---------------------------------------------------------------------------------------------------


function Button:draw()
    love.graphics.setColor(self.color)
    if self.isUnderMouse then
        if self.isPressed then
            love.graphics.draw(self.image, self.x + self.width/8, self.y + self.height/8, 0, 0.75, 0.75)
        else
            love.graphics.draw(self.image, self.x - self.width/8, self.y - self.height/8, 0, 1.25, 1.25)
        end
    else
        love.graphics.draw(self.image, self.x, self.y)
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>