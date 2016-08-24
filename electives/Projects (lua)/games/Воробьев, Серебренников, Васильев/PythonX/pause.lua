local pause = {}

suit = require 'libs/SUIT'

local buttonWidth = 300
local buttonHeight = 50

function pause:enter(from)
    self.from = from -- record previous state
    rect = {x = love.mouse.getX(),
      y = love.mouse.getY(),
      speed = 1}
    suit.enterFrame()
end

function pause:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 2, screenHeight * 0.1 + (screenHeight - buttonHeight * 5) / 2)
    suit.layout:padding(10)
    local playButton = suit.Button("Play", suit.layout:row(buttonWidth, buttonHeight))
    local menuButton = suit.Button("Menu", suit.layout:row())
    if playButton.hit then
        gamestate.switch(game)
    end
    if menuButton.hit then
        gamestate.switch(menu)
    end
  --[[if (math.sqrt(math.pow(love.mouse.getY() - rect.y, 2) + math.pow(love.mouse.getX() - rect.x, 2))) > 0 then
    
    local x = rect.x + 
    (math.min(rect.speed, (math.sqrt(math.pow(love.mouse.getY() - rect.y, 2) + math.pow(love.mouse.getX() - rect.x, 2)))) * 
    (love.mouse.getX() - rect.x)) / 
    (math.sqrt(math.pow(love.mouse.getY() - rect.y, 2) + math.pow(love.mouse.getX() - rect.x, 2)))
    
    local y = rect.y + 
    (math.min(rect.speed, (math.sqrt(math.pow(love.mouse.getY() - rect.y, 2) + math.pow(love.mouse.getX() - rect.x, 2)))) * 
    (love.mouse.getY() - rect.y)) / 
    (math.sqrt(math.pow(love.mouse.getY() - rect.y, 2) + math.pow(love.mouse.getX() - rect.x, 2)))
    
    rect.x = x
    rect.y = y
  end]]--
end

function pause:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- рисуем предыдущий экран
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    --love.graphics.printf('PAUSE', 0, screenHeight/2, screenWidth, 'center')
    suit.draw()
    --love.graphics.rectangle('fill', rect.x, rect.y, 10, 10)
end

function pause:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    else
        gamestate.switch(game)
    end
end

return pause