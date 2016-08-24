local game = {} 

--[[
    Создавать функции можно двумя способами
    1. Создавать локальные для файла функции. Они должны быть описаны ДО момента вызова, и они не видны в других местах
    Примеры функций: checkCollision, loadAssets, playSound
    2. Создать функции внутри таблицы:
        game:functionName(...)
        
        В таком случае функцию можно вызвать при обращении к таблице:
        
        game:movement(dt)
        
        Внутри таблицы такие функции вызываются при помощи специального слова self (ссылка таблицы на саму себя):
        
        self:enemySpawn(dt)
--]]

-- проверка пересечения двух прямоугольников
local function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return 
        x1 < x2+w2 and x2 < x1+w1 and
        y1 < y2+h2 and y2 < y1+h1
end

-- загрузка игровых материалов
local function loadAssets()
    -- загружаем картинки в память
    images = {
        background =    love.graphics.newImage("assets/background.png"),
        player =        love.graphics.newImage("assets/player.png"),
        bullet =        love.graphics.newImage("assets/fire.png"),
        enemies = {}
    }
    
    -- перебираем все изображения врагов, которые выполнены по шаблону "enemy<Цвет><Номер>"
    local colors = {"Black", "Blue", "Green", "Red"}
    
    for i=1,5 do
        for k,color in pairs(colors) do
            table.insert(images.enemies, love.graphics.newImage("assets/enemies/enemy" .. color .. i .. ".png"))
        end
    end
    
    -- загружаем звуки ("static" - храним в оперативной памяти весь файл, в противном случае (нет никакого параметра) считываем с диска каждый раз при обращении)
    sounds = {
        bullets = {
            love.audio.newSource("assets/sounds/sfx_laser1.ogg", "static"),
            love.audio.newSource("assets/sounds/sfx_laser2.ogg", "static")
        },
        
        enemyExplosion = love.audio.newSource("assets/sounds/sfx_twoTone.ogg", "static")
    }
end

--[[
    Функция работы со звуком, передаем звук, останавливаем и перематываем его, если он играет, и играем его с начала
--]]
local function playSound(sound)
    if sound:isPlaying() then
        sound:stop() -- остановка и перемотка
    end
    
    sound:play() -- само воспроизведение звука
end

-- Функция вызывается один раз при вызове gamestate.switch
function game:init()
    
    -- загрузка материалов - изображений и звуков
    loadAssets()

    -- загрузка констант 
    world = {
        shootInterval = 0.5, -- cooldown стрельбы/перезарядка - т.е. игрок может стрелять 1 раз в 0.5 секунд
        enemySpawnInterval = 1.5, -- cooldown появления врагов - т.е. новый враг появляется 1 раз в 1.5 секунд
        canEnemySpawn = true, -- переменная-флажок возможности появления нового врага
        enemySpawnTimer = 3 -- переменная-таймер для создания врагов
    }
    
    -- загрузка информации о игроке
    player = {
        x = love.graphics.getWidth() / 2, -- координаты по оси Х
        y = love.graphics.getHeight() / 2, -- координаты по оси Y
        height = images.player:getHeight() / 2, -- высота игрока (потому что мы отрисовку изображения уменьшили в 2 раза)
        width = images.player:getWidth() / 2, -- ширина игрока
        speedX = 150, -- скорость по оси Х
        speedY = 150, -- скорость по оси Y
        bullets = {}, -- пульки игрока
        canShoot = true, -- флаг, разрещающий стрелять
        shootTimer = world.shootInterval, -- таймер-cooldown (сколько времени нельзя стрелять)
        score = 0,-- очки
        isAlive = true -- жив ли игрок?
    }
    
    -- характеристики пули
    bulletStat = {
        speedY = 150 -- как быстро летит пуля
    }
    
    -- враги
    enemies = {}
    

end

-- Обновление игры (если состояние активно, то вызывается в love.update(dt))
function game:update(dt)
    -- если игрок живой, то обновляем состояние игры
    if player.isAlive then
    
        -- создание врага или обновление таймера
        self:enemySpawn(dt)
        
        --передвижение врагов
        self:moveEnemies(dt)
        
        --передвижение пуль
        self:moveBullets(dt)
        
        -- игрок
        -- стрельба (если нельзя стрелять, то уменьшаем таймер до тех пор, пока он не станет <= 0, в этом случае изменяем флажок)
        self:decreaseShootTimer(dt)
            
        -- границы мира  (за них нельзя вылезать, поэтому ограничиваем игрока)
        self:worldBorders(dt)
        
        -- управление игроком (таким образом можно вызывать функцию, которая относится к таблице)
        self:movement(dt)
        
        -- проверка пересечений пуль, врагов и игрока
        self:collisions(dt)
    
    else
        --[[
            что-нибудь, например, отслеживать нажатие клавиши R, обнулить все таблицы с врагами и пулями, и оживить игрока :)
        --]] 
    end
end

--[[

Отслеживание нажатия (ординарного) клавиши, необходимо использовать, если нужно повесить какое-нибудь событие 
Например, если нужно сделать паузу или выйти из игры

Принимается название клавиши, как и в love.keyboard.isDown(), и код этой клавиши
--]]
function game:keypressed(key, code)
    -- при любом раскладе игры (идет игра или игрок мертв) необходимо выйти из игры при нажатии escape
    if key == "escape" then
        --[[
            Если текущее состояние игры равное "game" (т.е. самому себе - self) и игрок живой, 
            то можно поставить игру на паузу - т.е. перевести в состояние "Пауза"
        --]]
        if gamestate.current() == self and player.isAlive then
            gamestate.switch(pause)
        end
    elseif key == "q" then
        -- обычный выход из игры
        love.event.push('quit')
    elseif key == "m" then
        gamestate.switch(menu)
    end
end

-- Отрисовка игры ((если состояние активно, то вызывается в love.draw()))
function game:draw()
    if player.isAlive then
        
        --[[
            отрисовка задника квадратиками по всей ширине экрана
            сперва заполняется первая строка, потом вторая и т.д.
         --]]
        local backgroundWidth = images.background:getWidth()
        local backgroundHeight = images.background:getHeight()
        
        for i = 0, screenWidth / backgroundWidth do
            for j = 0, screenHeight / backgroundHeight do
                love.graphics.draw(images.background, i * backgroundWidth, j * backgroundHeight)
            end
        end
        
        -- рисуем игрока
        love.graphics.draw(images.player, player.x, player.y, 0, 0.5, 0.5)

        -- рисуем пули из массива пуль
        for i,bullet in pairs(player.bullets) do
            love.graphics.draw(images.bullet, bullet.x, bullet.y)
        end
        
        -- рисуем врагов из массива врагов
        for i,enemy in pairs(enemies) do
            love.graphics.draw(images.enemies[enemy.imageIndex], enemy.x, enemy.y, 0, 0.5, 0.5)
        end
        
        -- отрисовка очков
        love.graphics.setColor(255, 255, 255)
        love.graphics.print("SCORE: " .. tostring(player.score), screenWidth * 0.05, screenHeight * 0.95)
    else
        love.graphics.print("Game over", screenWidth / 2, screenHeight / 2)
    end
end

-- Проверка выхода игрока за пределы мира
function game:worldBorders()
    if player.x < 0  then
        player.x = 0
    elseif player.x > screenWidth - player.width then
        player.x = screenWidth - player.width
    end
    
    if player.y < 0 then
        player.y = 0
    elseif player.y > screenHeight - player.height then
        player.y = screenHeight - player.height
    end
end

-- создание врагов + уменьшение таймера создания врагов
function game:enemySpawn(dt)
    if world.canEnemySpawn then
        -- создаем врага 
        local enemyIndex = math.random(1, #images.enemies)
        local enemyImage = images.enemies[enemyIndex]
        
        local enemyWidth = enemyImage:getWidth() / 2
        local enemyHeight = enemyImage:getHeight() / 2
        
        local enemy = {
            width = enemyWidth,
            height = enemyHeight,
            x = math.random(1, screenWidth - enemyWidth), -- уменьшаем границу справа, для того, чтобы корректно появлялись враги
            y = -enemyHeight, -- для того, чтобы враг появлялся из-за экрана
            speedY = math.random(5, 100),
            imageIndex = enemyIndex -- запоминаем индекс изображения
        }
        
        table.insert(enemies, enemy) -- записываем врага в таблицу врагов
        
        -- больше врагов нельзя создавать, до тех пор enemySpawnTimer не станет <= 0
        world.canEnemySpawn = false
        world.enemySpawnTimer = world.enemySpawnInterval
    else
        world.enemySpawnTimer = world.enemySpawnTimer - dt
        -- отсчитываем таймер до появления нового врага
        if world.enemySpawnTimer <= 0 then
            world.canEnemySpawn = true -- можем создавать нового врага
        end
    end
end

-- передвижение врагов
function game:moveEnemies(dt)
    for i,enemy in pairs(enemies) do
        enemy.y = enemy.y + enemy.speedY * dt
        
        -- если враг вышел за экран, то удаляем его из игры
        if enemy.y > screenHeight - enemy.height then
            table.remove(enemies, i)
        end
    end
end

-- передвижение пуль игрока (TODO: может быть ещё и вражеских?)
function game:moveBullets(dt)
    for i,bullet in pairs(player.bullets) do
        bullet.y = bullet.y - dt * bulletStat.speedY
        
        -- если пуля вышла из игры, то удаяем ее
        if bullet.y < 0 then
            table.remove(player.bullets, i)
        end
    end
end

-- уменьшение таймера выстрела
function game:decreaseShootTimer(dt)
    if not player.canShoot then
        player.shootTimer = player.shootTimer - dt
        
        if player.shootTimer <= 0 then
            player.canShoot = true
        end
    end
end

-- управление игроком
function game:movement(dt)
    -- управление игроком
    if love.keyboard.isDown('a', 'left') then
        player.x = player.x - dt * player.speedX
    end

    if love.keyboard.isDown('d', 'right') then
        player.x = player.x + dt * player.speedX
    end
    
    if love.keyboard.isDown('w', 'up') then
        player.y = player.y - dt * player.speedY
    end
    
    if love.keyboard.isDown('s', 'down') then
        player.y = player.y + dt * player.speedY
    end

    -- стрельба (стреляем, если есть возможность)
    if love.keyboard.isDown('space') and player.canShoot then
        local bullet = {
            x = player.x + (player.width - images.bullet:getWidth()) / 2,
            y = player.y
        }
        
        -- создали пулю и запретили стрелять
        table.insert(player.bullets, bullet)
        player.canShoot = false
        player.shootTimer = world.shootInterval
        
        -- играем звук
        local sound = sounds.bullets[math.random(1, 2)]
        playSound(sound)
    end
end

-- учет пересечений пуль, врагов и игрока
function game:collisions(dt)
    for i,enemy in pairs(enemies) do
        for j,bullet in pairs(player.bullets) do
            if checkCollision(
                enemy.x, enemy.y, enemy.width, enemy.height,
                bullet.x, bullet.y, images.bullet:getWidth(), images.bullet:getHeight()
            ) then
                table.remove(enemies, i)
                table.remove(player.bullets, j)
                player.score = player.score + 1 -- увеличиваем счет игрока
                
                local sound = sounds.enemyExplosion
                playSound(sound)
            end
        end
        
        if checkCollision(
            enemy.x, enemy.y, enemy.width, enemy.height,
            player.x, player.y, player.width, player.height
        ) then
            table.remove(enemies, i)
            player.isAlive = false
        end
    end
end


return game