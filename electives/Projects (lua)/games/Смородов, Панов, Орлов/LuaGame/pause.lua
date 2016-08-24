local pause = {}

function pause:enter(from,level,difffff)
    self.from = from -- record previous state
    lvl = level 
    d = difffff
end

function pause:draw()
      screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- рисуем предыдущий экран
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('ПАУЗА', 0, screenHeight/2, screenWidth, 'center')
    love.graphics.printf('Q - выйти из игры', 0, screenHeight/2+40, screenWidth, 'center')
    love.graphics.printf('R - вернуться в меню', 0, screenHeight/2+80, screenWidth, 'center')
    love.graphics.printf('O - начать заново', 0, screenHeight/2+120, screenWidth, 'center')
end

function pause:keypressed(key, code)
    if key == "escape" then
        gamestate.switch(game,lvl,d)
    elseif key == "q" then
        love.event.push('quit')
    elseif key == "r" then
        gamestate.switch(menu)
    elseif key == "o" then
        -- обычный выход из игры
        NeedInit = true
        gamestate.switch(game,level,dif)
    elseif key == "f" then
        -- обычный выход из игры
        love.window.setFullscreen(not love.window.getFullscreen())
        screenWidth = love.graphics.getWidth()
        screenHeight = love.graphics.getHeight()
        end
end
function game:mousefocus(f)
  if f == true then
  gamestate.switch(game,lvl,d)
  end
end
return pause
