local settings = {}

suit = require 'libs/SUIT'

Control = 1; -- 1 - mouse 2 - keybolard
local ControlPosition = "Mouse"
local buttonWidth = 300
local buttonHeight = 50
local logoOffset

function settings:init()
    loadAssets()
    settings.logoImage = love.graphics.newImage("assets/logo.png")
    logoOffset = screenHeight * 0.1
end

function settings:enter(from)
    suit.enterFrame()
end

function settings:update(dt)
 
    suit.layout:reset((screenWidth - buttonWidth) / 2, logoOffset + (screenHeight - buttonHeight * 5) / 2)
    suit.layout:padding(10) -- делаем отступ в 10 пикселей вокруг (!!!) элементов
    
    suit.Label("Settings", {align = "center"}, suit.layout:row(buttonWidth, buttonHeight))
    
    -- вариант с строчным расположением кнопок
    --suit.layout:row()
    
    local controlButton = suit.Button("Control", suit.layout:row())
    
    if controlButton.hit then
        if ControlPosition == "Keyboard" then
          Control = 1
          ControlPosition = "Mouse"
        elseif ControlPosition == "Mouse" then
          Control = 2
          ControlPosition = "Keyboard"
        end
    end
    
    
    suit.Label(ControlPosition, {align = "center"}, suit.layout:row(buttonWidth, buttonHeight))
    local exitButton = suit.Button("Menu", suit.layout:row())
    
    if exitButton.hit then
        gamestate.switch(menu)
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

function settings:draw()
    -- здесь можно рисовать что-угодно (например красивый фон)!
    local backgroundWidth = images.background:getWidth()
    local backgroundHeight = images.background:getHeight()
    love.graphics.draw(images.background)
    love.graphics.draw(menu.logoImage, (screenWidth - menu.logoImage:getWidth()) / 2, screenHeight * 0.1)
    suit.draw()
end

return settings