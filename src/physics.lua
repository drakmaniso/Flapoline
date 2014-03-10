physics = {}


---------------------------------------------------------------------------------------------------


local function clamp(value, lower, upper)
    return math.max(lower, math.min(upper, value))
end


---------------------------------------------------------------------------------------------------


function acrobatCollidesWith(item)
    local closestX = clamp(acrobat.x, item.x, item.x + item.width)
    local closestY = clamp(acrobat.y, item.y, item.y + item.height)
    local distanceX = acrobat.x - closestX
    local distanceY = acrobat.y - closestY
    local distanceSquared = distanceX * distanceX + distanceY * distanceY
    return distanceSquared < acrobat.radiusSquared
end


---------------------------------------------------------------------------------------------------


function physics:update(dt)
    if acrobatCollidesWith(trampoline) then

        if acrobat.speed > 0 then
            local overshotDistance = acrobat.y + acrobat.radius - trampoline.y
            local overShotTime = math.max(0, overshotDistance / acrobat.speed)
            local collisionX = acrobat.x - trampoline.speed * overShotTime
            trail:placeDot(collisionX, trampoline.y - acrobat.radius)
            acrobat.timer = 0
            acrobat.speed = -acrobat.reboundSpeed
            acrobat.acceleration = -acrobat.reboundAcceleration
            acrobat.y = trampoline.y - acrobat.radius + acrobat.speed * (dt - overShotTime)
            trampoline:startRebound()
        else
            acrobat.speed = - acrobat.speed
            acrobat.y = trampoline.y + trampoline.height + acrobat.radius
        end

    elseif acrobat.y - acrobat.radius - 1 > virtualHeight then

        inGameOver.collisionY = 2 * virtualHeight
        inGameOver.collisionX = 0
        return inGameOver

    else

        for _,obstacle in ipairs(obstacles.ring) do
            if acrobatCollidesWith(obstacle.upper) then
                inGameOver.collisionX = clamp(acrobat.x, obstacle.upper.x, obstacle.upper.x + obstacle.upper.width)
                inGameOver.collisionY = clamp(acrobat.y, obstacle.upper.y, obstacle.upper.y + obstacle.upper.height)
                return inGameOver
            elseif acrobatCollidesWith(obstacle.lower) then
                inGameOver.collisionX = clamp(acrobat.x, obstacle.lower.x, obstacle.lower.x + obstacle.lower.width)
                inGameOver.collisionY = clamp(acrobat.y, obstacle.lower.y, obstacle.lower.y + obstacle.lower.height)
                return inGameOver
            end
        end

    end

    return false
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>