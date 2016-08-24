local pravila = {}

suit = require 'libs/suit'
local buttonWidth = 200
local buttonHeight = 30
local logolOffset

function pravila:init()
    logolOffset = screenHeight * 0
end

function pravila:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 2, logolOffset + (screenHeight - buttonHeight * 5) / 1)
    suit.layout:padding(10) -- делаем отступ в 10 пикселей вокруг (!!!) элементов
    local playButton = suit.Button("НАЗАД", suit.layout:row(buttonWidth, buttonHeight))
    
    if playButton.hit then
        gamestate.switch(menu)
    end
end

-- не трогай!!!
function pravila:enter(from)
    self.from = from -- record previous state
end

function pravila:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- рисуем предыдущий экран
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
    love.graphics.printf('С б и в а й   ф р у к т ы   и   о в о щ и   и   п о л у ч а й   о ч к и !', 0, screenHeight/3, screenWidth, 'center')
     love.graphics.printf( 'З а  с б и т ы й   а р б у з   +10   о ч к о в ,   в и н о г р а д   и   м о р к о в ь   +7 ,  п о м и д о р ,   а н а н а с ,   а п е л ь с и н ,   я б л о к о   и   г р у ш а   +1 .   З а   с б и т о г о   к о с м о н а в т а   -5   о ч к o в ,   з а   л е т а ю щ у ю   т а р е л к у   -50 .', 0, screenHeight/2, screenWidth, 'center')
     love.graphics.printf( 'Г л а в н о е   н и   в   к о г о   н е   в р е з а т ь с я ,   и н а ч е   и г р а   б у д е т   о к о н ч е н а .', 0, screenHeight/1.5, screenWidth, 'center')
end
return pravila