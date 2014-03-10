require "src/shufflebag"

require "src/acrobat"
require "src/dot"
require "src/trail"
require "src/trampoline"
require "src/layer"
require "src/obstacle"
require "src/clouds"
require "src/mountain"
require "src/physics"

require "src/button"

require "src/intitle"
require "src/instart"
require "src/inrestart"
require "src/ingame"
require "src/ingameover"

require  "src/constants"


---------------------------------------------------------------------------------------------------


function love.load()
    math.randomseed(os.time())
    virtualHeight = 720

    scoreFont = love.graphics.newFont("data/vic_fieger_helsinki.ttf", 48)
    bigScoreFont = love.graphics.newFont("data/vic_fieger_helsinki.ttf", 128)
    clickFont = love.graphics.newFont("data/vic_fieger_helsinki.ttf", 24)
    smallFont = love.graphics.newFont("data/vic_fieger_helsinki.ttf", 16)

    save = love.filesystem.newFile("score")

    inTitle:initialize()
    inGame:initialize()
    inGameOver:initialize()

    Cloud:initialize()
    Mountain:initialize()
    Obstacle:initialize()

    skyImage = love.graphics.newImage("data/sky.png")
    love.resize(love.window.getWidth(), love.window.getHeight())

    score = 0
    highScore = 0
    if love.filesystem.exists("score") then
        save:open("r")
        highScoreText = save:read()
        save:close()
        highScore = tonumber(highScoreText)
    end
    hasNewHighScore = 0

    state = inTitle
    state:enter()
end


---------------------------------------------------------------------------------------------------


function love.resize(width, height)
    virtualScale = height / virtualHeight
    virtualWidth = width / virtualScale
    skyQuad = love.graphics.newQuad(0, 0, virtualWidth, virtualHeight, skyImage:getWidth(), skyImage:getHeight())

    clouds = Layer:new(math.modf(virtualWidth / Cloud.stride) + 2, Cloud, 0)
    mountains = Layer:new(math.modf(virtualWidth / Mountain.stride) + 2, Mountain, -Mountain.stride)
    mountainsBack = Layer:new(math.modf(virtualWidth / Mountain.stride) + 2, Mountain, -Mountain.stride/2)
    obstacles = Layer:new(
            math.modf(virtualWidth / Obstacle.stride) + 2, 
            Obstacle, 
            virtualWidth + 32
        )

    inTitle.fullscreenButton:setPosition(virtualWidth - 48 - 16, 16)
    inTitle.soundButton:setPosition(virtualWidth - 48 - 16 - 48 - 16, 16)
    inTitle.playButton:setPosition(virtualWidth/2 - inTitle.playButton.width/2, 48+16 + inTitle.title:getHeight() + 0 + 2*clickFont:getHeight(text1) + 64)
end


---------------------------------------------------------------------------------------------------


function love.keypressed(key)
    if key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
    state:keypressed(key)
end


---------------------------------------------------------------------------------------------------


function love.mousepressed(x, y, button)
    state:mousepressed(x / virtualScale, y / virtualScale, button)
end


---------------------------------------------------------------------------------------------------


function love.mousereleased(x, y, button)
    state:mousereleased(x / virtualScale, y / virtualScale, button)
end


---------------------------------------------------------------------------------------------------


function love.update(dt)
    --dt = dt / 2
    local newState = state:update(dt)
    if newState then
        state:leave()
        state = newState
        state:enter()
    end
end


---------------------------------------------------------------------------------------------------


function love.draw()
    love.graphics.scale(virtualScale, virtualScale)
    state:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>