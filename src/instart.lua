inStart = {}


---------------------------------------------------------------------------------------------------


function inStart:enter()
    self.exitRequested = false
    self.startRequested = false

    self.title = love.graphics.newImage("data/title.png")

    acrobat:initialize()
    trail:initialize()
    trampoline:initialize()

    self.backButton = Button:new(
            function ()
                self.exitRequested = true
            end,
            "data/menu.png",
            16,
            16,
            {255, 255, 255, 96}
        )
end


---------------------------------------------------------------------------------------------------


function inStart:leave()
end


---------------------------------------------------------------------------------------------------


function inStart:keypressed(key)
    if key == "escape" then
        self.exitRequested = true
    end
end


---------------------------------------------------------------------------------------------------


function inStart:mousepressed(x, y, button)
    if not self.backButton:mousepressed(x, y, pressed) then
       self.startRequested = true
        trampoline:setPosition(x, y)
    end
end


---------------------------------------------------------------------------------------------------


function inStart:mousereleased(x, y, button)
    self.backButton:mousereleased(x, y, pressed)
end


---------------------------------------------------------------------------------------------------


function inStart:update(dt)
    if self.exitRequested then
        return inTitle
    end

    clouds:update(dt)
    mountains:update(dt)
    mountainsBack:update(dt)

    self.backButton:update(dt)

    acrobat:flyingUpdate(dt)

    if self.startRequested then
        return inGame
    else
        return false
    end         
end


---------------------------------------------------------------------------------------------------


function inStart:drawClickMessage()
    love.graphics.setFont(clickFont)
    love.graphics.setColor(255, 255, 255)
    local text = "Click! Click!"
    love.graphics.print(text, acrobat.x - clickFont:getWidth(text)/2, virtualHeight/2 + 64)
end


---------------------------------------------------------------------------------------------------


function inStart:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(skyImage, skyQuad, 0, 0)
    clouds:draw()
    mountains:draw()
    mountainsBack:draw()

    self.backButton:draw()

    acrobat:draw()
    self:drawClickMessage()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>