gamestate = require "libs/gamestate" -- загружаем в глобальную переменную библиотеку по работе с состояниями
game = require "game" -- загружаем модуль состояния "Игра"
menu = require "menu" -- загружаем модуль состояния "Меню"
pause = require "pause" -- загружаем модуль состояния "Пауза"

function love.load()
    -- данная строчка необходима для отладки игры в среде ZeroBrane!
    if arg[#arg] == "-debug" then require("mobdebug").start() end
    
    io.stdout:setvbuf("no") -- для вывода print сразу же в output
    
    math.randomseed(os.time()) -- задание новой последовательности рандомных чисел на основе текущего времени
   
    -- курсор
    local cursorPath = "assets/cursor.png"
    local cursorImage = love.graphics.newImage(cursorPath)
    cursor = love.mouse.newCursor(cursorPath, cursorImage:getWidth() / 2, cursorImage:getHeight() / 2)
    love.mouse.setCursor(cursor)
   
    -- получаем ширину и высоту игрового окна
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()
   
    -- загружаем шрифт в переменную (1 - путь до шрифта, 2 - размер шрифта)
    font = love.graphics.newFont("fonts/kenvector_future.ttf")
    love.graphics.setFont(font) -- вставляем шрифт
   
    -- регистриуем события для состояний
    gamestate.registerEvents()
    -- выставляем текущее состояние игры в "Меню"
    gamestate.switch(menu)
end