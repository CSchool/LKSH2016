local menu = {}

suit = require 'libs/suit'

local buttonWidth = 200
local buttonHeight = 30
local logoOffset

function menu:init()
    menu.logoImage = love.graphics.newImage("assets/logo.png")
    logoOffset = screenHeight * 0.1
end

function menu:enter(from)
    suit.enterFrame()
end

function menu:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 2, logoOffset + (screenHeight - buttonHeight * 5) / 2)
    suit.layout:padding(10) -- делаем отступ в 10 пикселей вокруг (!!!) элементов
    
    suit.Label("Menu", {align = "center"}, suit.layout:row(buttonWidth, buttonHeight))
    
    -- вариант с строчным расположением кнопок
    
    suit.layout:row()
    
    local playButton = suit.Button("Play", suit.layout:row())
    
    if playButton.hit then
        gamestate.switch(game)
    end
    
    suit.layout:row()
    
    local exitButton = suit.Button("Exit", suit.layout:row())
    
    if exitButton.hit then
        love.event.push('quit')
    end
    
    --[[
    -- Вариант со колоночным расположением кнопок
    
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
    
    love.graphics.draw(menu.logoImage, (screenWidth - menu.logoImage:getWidth()) / 2, screenHeight * 0.1)
    suit.draw()
end

return menu