trampoline = {}


---------------------------------------------------------------------------------------------------


trampoline.boiing = love.audio.newSource("data/boiing.wav")
trampoline.boiing:setVolume(1.0)
trampoline.plop = love.audio.newSource("data/plop.wav")
trampoline.plop:setVolume(1.0)


---------------------------------------------------------------------------------------------------


function trampoline:initialize ()
    self.x = 256 - self.width / 2
    self.y = virtualHeight + 128
    self.timer = 0
    self.deltaY = 0
end


---------------------------------------------------------------------------------------------------


function trampoline:startRebound()
    trampoline.timer = 0.5
    self.boiing:stop()
    self.boiing:play()
end


---------------------------------------------------------------------------------------------------


function trampoline:vibrationUpdate(dt)
    if self.timer > 0 then
        self.deltaY = math.sin(self.timer * 10 * math.pi) * self.timer * 32
        self.timer = math.max(0, self.timer - dt)
        if self.timer == 0 then
            self.deltaY = 0
        end
    end
end


---------------------------------------------------------------------------------------------------


function trampoline:update(dt)
    self.x = self.x - self.speed * dt
    self:vibrationUpdate(dt)
end


---------------------------------------------------------------------------------------------------


function trampoline:gameOverUpdate(dt)
    self:vibrationUpdate(dt)    if self.timer > 0 then
        self.deltaY = math.sin(self.timer * 10 * math.pi) * self.timer * 32
        self.timer = math.max(0, self.timer - dt)
        if self.timer == 0 then
            self.deltaY = 0
        end
    end

end


---------------------------------------------------------------------------------------------------


function trampoline:setPosition(x, y)
    self.plop:stop()
    self.plop:play()
    self.x = x - self.width / 2
    self.y = y - self.height / 2
    self.timer = 0
    self.deltaY = 0

    if acrobatCollidesWith(self) then
        self.y = acrobat.y + acrobat.radius + 1
    end

    if state ~= inGame then return end

    -- Adjust position of the trampoline if it collides with an obstacle
    for _,obstacle in ipairs(obstacles.ring) do
        if 
            self.x < obstacle.lower.x + obstacle.lower.width
            and self.x + self.width > obstacle.lower.x
            and self.y + self.height > obstacle.lower.y
        then
            if x < obstacle.lower.x then
                self.x = obstacle.lower.x - self.width
            elseif x > obstacle.lower.x + obstacle.lower.width then
                self.x = obstacle.lower.x + obstacle.width
            else
                self.y = obstacle.lower.y - self.height
            end

        elseif 
            self.x < obstacle.upper.x + obstacle.upper.width
            and self.x + self.width > obstacle.upper.x
            and self.y < obstacle.upper.y + obstacle.upper.height
        then
            if x < obstacle.upper.x then
                self.x = obstacle.upper.x - self.width
            elseif x > obstacle.upper.x + obstacle.upper.width then
                self.x = obstacle.upper.x + obstacle.width
            else
                self.y = obstacle.upper.y + obstacle.upper.height
            end
        end
    end
end


---------------------------------------------------------------------------------------------------


function trampoline:draw()
    love.graphics.setColor(30, 30, 30)
    love.graphics.setLineWidth(self.height)
    local y = self.y + self.height / 2
    love.graphics.line(
            self.x, y, 
            self.x + self.width/4, y + 3*self.deltaY/4, 
            self.x + self.width/2, y + self.deltaY, 
            self.x + 3*self.width/4, y + 3*self.deltaY/4, 
            self.x + self.width, y
        )
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>