local menu = {}

suit = require 'libs/suit'

local buttonWidth = 200
local buttonHeight = 30
local logolOffset

function menu:init()
    menu.logolImage = love.graphics.newImage("assets/logol.png")
    logolOffset = screenHeight * 0
end

function menu:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 10, logolOffset + (screenHeight - buttonHeight * 5) / 5)
    suit.layout:padding(10) -- делаем отступ в 10 пикселей вокруг (!!!) элементов
    
    suit.Label("МЕНЮ", {align = "center"}, suit.layout:row(buttonWidth, buttonHeight))
    
    -- вариант с строчным расположением кнопок
    
    suit.layout:row()
    
    local playButton = suit.Button("ИГРАТЬ!", suit.layout:row())
    
    if playButton.hit then
        gamestate.switch(game)
    end
    
    suit.layout:row()
    
    local prButton = suit.Button("ПРАВИЛА", suit.layout:row())
    
    if prButton.hit then
      gamestate.switch(pravila)
    end
    
    suit.layout:row()
        
    local ypravlenieButton = suit.Button("УПРАВЛЕНИИЕ", suit.layout:row())
    
    if ypravlenieButton.hit then
      gamestate.switch(ypravlenie)
    end
    
    suit.layout:row()
    
    local exitButton = suit.Button("ВЫХОД", suit.layout:row())
    
    if exitButton.hit then
        love.event.push('quit')
    end
    
    
    -- Вариант со колоночным расположением кнопок
    --[[
    suit.layout:row(0)
    
    local playButton = suit.Button("Play", suit.layout:col(80, buttonHeight))
    
    if playButton.hit then
        gamestate.switch(game)
    end
    
    local exitButton = suit.Button("Exit", suit.layout:col())
    
    if exitButton.hit then
        love.event.push('quit')
    end
    --]]
end

function menu:draw()
    -- здесь можно рисовать что-угодно (например красивый фон)!
    love.graphics.draw(menu.logolImage, (screenWidth - menu.logolImage:getWidth()) / 2, screenHeight * 0.001)
    
    suit.draw()
end

return menu