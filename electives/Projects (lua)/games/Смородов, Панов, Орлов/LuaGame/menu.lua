local menu = {}

suit = require 'libs/suit'

local buttonWidth = love.graphics.getWidth() / 2
local buttonHeight = 50
local logoOffset


function menu:init()
    menu.logoImage = love.graphics.newImage("assets/logo.png")
    logoOffset = screenHeight * 0.1
end
function menu:enter(from)
  suit.enterFrame()
  file = io.open("levels.txt", "r")
  local count = 1
  while true do
    local line = file:read()
    if line == nil then break end
      if tonumber(line) < 0 then 
        if tonumber(line) == -1 then 
            stlevel1 = file:read()
        end
        if tonumber(line) == -2 then 
          stlevel2 = file:read()
        end
        if tonumber(line) == -3 then 
            stlevel3 = file:read()
        end
      end
  end
end
function menu:switchstate(state,lvl,diff)
  gamestate.switch(state,lvl,diff)
  end

function menu:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 2, logoOffset + (screenHeight - buttonHeight * 5) / 2)
    buttonWidth = love.graphics.getWidth() / 2
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
    suit.layout:padding(-20) -- делаем отступ в -20 пикселей вокруг (!!!) элементов
    
    suit.Label("МЕНЮ", {align = "center"}, suit.layout:row(buttonWidth, buttonHeight))
    
    -- вариант с строчным расположением кнопок
    
    suit.layout:row()
    
    local easyButton = suit.Button("ИГРА - ЛЕГКО", suit.layout:row())
    if easyButton.hit then 
      NeedInit = true
      gamestate.switch(game,1,stlevel1)
      end
    suit.layout:row()
    local normalButton = suit.Button("ИГРА - НОРМАЛЬНО", suit.layout:row())
    if normalButton.hit then 
      NeedInit = true
      gamestate.switch(game,2,stlevel2)
      end
    suit.layout:row()
    local hardButton = suit.Button("ИГРА - НЕРЕАЛЬНО", suit.layout:row())
    if hardButton.hit then 
      NeedInit = true
      gamestate.switch(game,3,stlevel3)
      end
    suit.layout:row()
    local exitButton = suit.Button("ВЫХОД", suit.layout:row())
    
    if exitButton.hit then
        love.event.push('quit')
    end 
    
  
    
    --[[ Вариан т со колоночным расположением кнопок
    
    suit.layout:row(0)
    
    local playButton = suit.Button("Play", suit.layout:col(80, buttonHeight))
    
    if playButton.hit then
        gamestate.switch(game)
    end
    
    local exitButton = suit.Button("Exit", suit.layout:col())
    
    if exitButton.hit then
        love.event.push('quit')
    end
    ]]--
    
end

function menu:draw()
    -- здесь можно рисовать что-угодно (например красивый фон)!
      love.graphics.draw(menu.logoImage, (screenWidth - menu.logoImage:getWidth()) / 2, screenHeight * 0.1)
      suit.draw()
end
  function menu:keypressed()
          if key == "f" then
        -- обычный выход из игры
        love.window.setFullscreen(not love.window.getFullscreen())
        screenWidth = love.graphics.getWidth()
        screenHeight = love.graphics.getHeight()
        end
    end
return menu


