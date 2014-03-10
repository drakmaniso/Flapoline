acrobat = {}


---------------------------------------------------------------------------------------------------


function acrobat:initialize()
    self.images = {}
    for i=1,11 do
        self.images[i] = {}
        for j=1,5 do
            self.images[i][j] = love.graphics.newImage("data/acrobat_" .. i .. "_" .. j .. ".png")
        end
        self.images[i][6] = self.images[i][4]
        self.images[i][7] = self.images[i][3]
        self.images[i][8] = self.images[i][2]
    end

    self.x = 256
    self.y = virtualHeight / 2
    self.speed = 0
    self.timer = 0
    self.flyingTimer = 0
end


---------------------------------------------------------------------------------------------------


function acrobat:flyingUpdate(dt)
    self.flyingTimer = self.flyingTimer + dt
    self.y = virtualHeight/2 + math.sin(self.flyingTimer * 8) * 8
end


---------------------------------------------------------------------------------------------------


function acrobat:update(dt)
    self.y = self.y + self.speed * dt
    self.speed = self.speed + self.acceleration * dt
    self.acceleration = self.acceleration + self.jerk * dt

    self.flyingTimer = self.flyingTimer + dt
    self.timer = self.timer + dt
    if self.timer > self.timeBetweenDots then
        trail:placeDot(self.x, self.y)
        self.timer = 0
    end
end


---------------------------------------------------------------------------------------------------


function acrobat:draw()
    love.graphics.setColor(255, 255, 255)
    local i = math.modf((self.flyingTimer * 32) % 8) + 1
    if self.speed < -100 then
        love.graphics.draw(self.images[1][i], self.x - 50, self.y - 50)
    elseif self.speed < -80 then
        love.graphics.draw(self.images[2][i], self.x - 50, self.y - 50)
    elseif self.speed <  -60 then
        love.graphics.draw(self.images[3][i], self.x - 50, self.y - 50)
    elseif self.speed <  -40 then
        love.graphics.draw(self.images[4][i], self.x - 50, self.y - 50)
    elseif self.speed < - 20 then
        love.graphics.draw(self.images[5][i], self.x - 50, self.y - 50)
    elseif self.speed <   20 then
        love.graphics.draw(self.images[6][i], self.x - 50, self.y - 50)
    elseif self.speed <  40 then
        love.graphics.draw(self.images[7][i], self.x - 50, self.y - 50)
    elseif self.speed <  60 then
        love.graphics.draw(self.images[8][i], self.x - 50, self.y - 50)
    elseif self.speed <  80 then
        love.graphics.draw(self.images[9][i], self.x - 50, self.y - 50)
    elseif self.speed <  100 then
        love.graphics.draw(self.images[10][i], self.x - 50, self.y - 50)
    else
        love.graphics.draw(self.images[11][i], self.x - 50, self.y - 50)
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>