local pause = {}

function pause:enter(from)
    self.from = from -- record previous state
end

function pause:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- рисуем предыдущий экран
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('ПАУЗА', 0, screenHeight/2, screenWidth, 'center')
end

function pause:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game)
    elseif key == "q" then
        love.event.push('quit')
    end
end

return pause