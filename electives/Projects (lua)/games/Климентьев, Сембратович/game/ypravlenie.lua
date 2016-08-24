local ypravlenie = {}

suit = require 'libs/suit'
local buttonWidth = 200
local buttonHeight = 30
local logolOffset

function ypravlenie:init()
    logolOffset = screenHeight * 0
end

function ypravlenie:update(dt)
    suit.layout:reset((screenWidth - buttonWidth) / 2, logolOffset + (screenHeight - buttonHeight * 5) / 1.4)
    suit.layout:padding(10) -- делаем отступ в 10 пикселей вокруг (!!!) элементов
    local playButton = suit.Button("НАЗАД", suit.layout:row(buttonWidth, buttonHeight))
    
    if playButton.hit then
        gamestate.switch(menu)
    end
end

-- не трогай!!!
function ypravlenie:enter(from)
    self.from = from -- record previous state
end

function ypravlenie:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()
    -- рисуем предыдущий экран
    self.from:draw()
    -- overlay with pause message
    love.graphics.setColor(0,0,0, 100)
    love.graphics.rectangle('fill', 0,0, screenWidth, screenHeight)
    love.graphics.setColor(255,255,255)
     love.graphics.printf( 'У п р а в л е н и е   з в е з д о л ё т а   с т р е л к а м и .   П р о б е л   –   в ы с т р е л .   E s c   –   п а у з а .     ‘ ’ Q ’ ’   –   з а к р ы т и е   о к н а .', 0, screenHeight/2, screenWidth, 'center')
     love.graphics.printf( 'У д а ч и !', 0, screenHeight/1.9, screenWidth, 'center')
end
return ypravlenie