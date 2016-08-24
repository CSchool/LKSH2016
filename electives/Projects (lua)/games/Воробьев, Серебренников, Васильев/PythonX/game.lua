local game = {} 


local entity = {}


-- проверка пересечения двух прямоугольников
local function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return 
        x1 < x2+w2 and x2 < x1+w1 and
        y1 < y2+h2 and y2 < y1+h1
end

local function vectorMove(x1,y1, x2,y2 ,sx,sy, dt)
  if (math.sqrt(math.pow(y1 - y2, 2) + math.pow(x1 - x2, 2))) > 0 then
      local x = x2 + (math.min(sx * dt, (math.sqrt(math.pow(y1 - y2, 2) + 
      math.pow(x1 - x2, 2)))) * (x1 - x2)) / 
      (math.sqrt(math.pow(y1 - y2, 2) + math.pow(x1 - x2, 2)))
      local y = y2 + (math.min(sy * dt, (math.sqrt(math.pow(y1 - y2, 2) + 
      math.pow(x1 - x2, 2)))) * 
      (y1 - y2)) / (math.sqrt(math.pow(y1 - y2, 2) + 
      math.pow(x1 - x2, 2))) 
      return x, y
    else
      return x2, y2
    end
end

local function lowHealth(health)
    return health <= 0
end

function game:energyRefresh(dt)
    if player.energy >= 1000 then
        player.energy = 1000
    else
        player.energy = player.energy + dt*20
    end
end
-- загрузка игровых материалов
function loadAssets()
    -- загружаем картинки в память
    images = {
        healthString =  love.graphics.newImage("assets/healthString.png"),
        background =    love.graphics.newImage("assets/SpaceBackground.jpg"),
        player =        love.graphics.newImage("assets/player.png"),
        bullet =        love.graphics.newImage("assets/fire2.png"),
        bullet2 =       love.graphics.newImage("assets/laserRed12.png"),
        healthBonus =   love.graphics.newImage("assets/healthBonus.png"),
        energyString =   love.graphics.newImage("assets/energyString.png"),
        energyBonus =   love.graphics.newImage("assets/energyBonus.png"),
        boss =          love.graphics.newImage("assets/boss.png"),
        meteor =        love.graphics.newImage("assets/meteor.png"),
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
        boom = love.audio.newSource("assets/sounds/boom_01.mp3", "static"),
        bullets = {
            love.audio.newSource("assets/sounds/sfx_laser1.ogg", "static"),
            love.audio.newSource("assets/sounds/sfx_laser2.ogg", "static")
        },
        
        enemyExplosion = love.audio.newSource("assets/sounds/sfx_twoTone.ogg", "static")
    }
end


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
        bulletInterval = 0.5,
        shootInterval = 0.5, -- cooldown стрельбы/перезарядка - т.е. игрок может стрелять 1 раз в 0.5 секунд
        enemySpawnInterval = 1.5, -- cooldown появления врагов - т.е. новый враг появляется 1 раз в 1.5 секунд
        bonusSpawnInterval = math.random(15, 30),
        canEnemySpawn = true, -- переменная-флажок возможности появления нового врага
        canBonusSpawn = false,
        canMeteorSpawn = false,
        enemySpawnTimer = 4, -- переменная-таймер для создания врагов
        bonusSpawnTimer = 4,
        meteorSpawnTimer = 4,
        shootTimerFactor = 1,
        canBossSpawn = true,
        bossSpawnTimer = 30
    }
    
    -- загрузка информации о игроке
    player = {
        health = 1000,
        energy = 1000,
        x = (love.graphics.getWidth() - images.player:getWidth()) / 2, -- координаты по оси Х
        y = (love.graphics.getHeight() - images.player:getHeight()) / 2, -- координаты по оси Y
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
        speedY = 300, -- как быстро летит пуля
        bulletWidth = images.bullet:getHeight() / 2, -- высота пули (потому что мы отрисовку изображения уменьшили в 2 раза)
        bulletHeight = images.bullet:getWidth() / 2, -- ширина пули
    }
    
    -- враги
    entity.enemies = {}
    entity.bonuses = {}

end

function entity.newEnemy(h, t)
  if t == 1 then
    local enemyIndex = math.random(1, #images.enemies)
    local img = images.enemies[enemyIndex]
    local enemy = {
            Type = t,
            rad = 0,
            health = h,
            scaleWidth = 0.5,
            scaleHeight = 0.5,
            rotate = 0,
            width = img:getWidth() / 2,
            height = img:getHeight() / 2,
            x,
            axis = math.random(1, screenWidth - img:getWidth()), -- уменьшаем границу справа, для того, чтобы корректно появлялись враги
            y = -img:getHeight(), -- для того, чтобы враг появлялся из-за экрана
            k = math.random(1, 2),
            speedY = math.random(50, 100),
            image = img
        }
    table.insert(entity.enemies, enemy)
  elseif t == 2 then
    local enemyIndex = math.random(1, #images.enemies)
    local img = images.enemies[enemyIndex]
    local k = math.random(-2, 2)
    local enemy = {
            Type = t,
            health = h,
            scaleWidth = 0.5,
            scaleHeight = 0.5,
            rotate = 0,
            width = img:getWidth() / 2,
            height = img:getHeight() / 2,
            axis = k < 5 and math.random(1, screenWidth / 2) or math.random(screenWidth / 2, screenWidth - img:getWidth()),
            x,
            y = -img:getHeight(), -- для того, чтобы враг появлялся из-за экрана
            k = k / 4,
            speedY = math.random(50, 100),
            image = img
        }
    table.insert(entity.enemies, enemy)
  elseif t == 10 then
    local img = images.boss
    local enemy = {
            Type = t,
            canShoot = false,
            shootTimer = world.shootInterval,
            bullets = {},
            health = h,
            scaleWidth = 2,
            scaleHeight = 2,
            rotate = 0,
            width = img:getWidth() * 2,
            height = img:getHeight() * 2,
            x = (screenWidth - img:getWidth()) / 2,
            y = -img:getHeight(),
            speedY = 25,
            speedX = 25,
            image = img
        }
    table.insert(entity.enemies, enemy)    
  end
end

function entity.move(obj, dt)
  if obj.Type == 1 then
    obj.y = obj.y + obj.speedY * dt
    obj.x = obj.k * math.sin(obj.rad) * 100 + obj.axis
    obj.rad = obj.rad + dt
  elseif obj.Type == 2 then
    obj.y = obj.y + obj.speedY * dt
    obj.x = obj.y * obj.k + obj.axis
  elseif obj.Type == 10 then
    if obj.y >= (screenHeight - obj.width) / 2 then
      obj.x, obj.y = vectorMove(player.x - obj.width / 2, obj.y, obj.x, obj.y, obj.speedX, obj.speedY, dt)
    else
      obj.x, obj.y = vectorMove(player.x - obj.width / 2, player.y, obj.x, obj.y, obj.speedX, obj.speedY, dt)
    end
    entity.Shoot(obj, dt)
    for j,bullet in pairs(obj.bullets) do
      bullet.y = bullet.y + dt * bulletStat.speedY
      if bullet.y > screenHeight then
        table.remove(obj.bullets, j)
      end
    end
  end
end

function entity.Shoot(obj, dt)
  if obj.Type == 10 then
    if obj.canShoot then
      local bullet = {
          width = images.bullet:getWidth(),
          height = images.bullet:getHeight(),
          image = images.bullet,
          x = obj.x + (obj.width - images.bullet:getWidth()) / 2,
          y = obj.y + obj.height
      }
      table.insert(obj.bullets, bullet)
      obj.canShoot = false
      obj.shootTimer = world.shootInterval
      local sound = sounds.bullets[math.random(1, 2)]
      playSound(sound)
    else
      obj.shootTimer = obj.shootTimer - dt
      if obj.shootTimer <= 0 then
        obj.canShoot = true
      end
    end
  end
end

-- Обновление игры (если состояние активно, то вызывается в love.update(dt))
function game:update(dt)
    -- если игрок живой, то обновляем состояние игры
    if player.isAlive then
      
        self:bonusSpawn(dt)
        
        -- создание врага или обновление таймера
        self:enemySpawn(dt)
        
        self:bossSpawn(dt)
        
        --передвижение врагов
        self:moveEnemies(dt)
        
        -- Движение бонусов
        self:moveBonuses(dt)
        
        --передвижение пуль
        self:moveBullets(dt)
        
        -- игрок
        -- стрельба (если нельзя стрелять, то уменьшаем таймер до тех пор, пока он не станет <= 0, в этом случае изменяем флажок)
        self:decreaseShootTimer(dt)
        
        self:movement(dt)
            
        -- границы мира  (за них нельзя вылезать, поэтому ограничиваем игрока)
        self:worldBorders(dt)
        
        self:collisions(dt)
        
        self:energyRefresh(dt)
      
      if player.score > 5 and #entity.enemies == 0 then
        gamestate.switch(win)
      end
      
    else
        --[[
            что-нибудь, например, отслеживать нажатие клавиши R, обнулить все таблицы с врагами и пулями, и оживить игрока :)
        --]] 
        if love.keyboard.isDown('r') then
            for k, v in pairs(entity.enemies) do
              entity.enemies[k] = nil
            end
            for k, v in pairs(entity.bonuses) do
              entity.bonuses[k] = nil
            end
            canBossSpawn = true
            player.isAlive = true
            player.health = 1000
            player.energy = 1000
            player.score = 0
            player.x = love.graphics.getWidth() / 2 -- координаты по оси Х
            player.y = love.graphics.getHeight() / 2 -- координаты по оси Y
            for k, v in pairs(player.bullets) do
              player.bullets[k] = nil
            end
        end
    end
end

function game:keypressed(key, code)
    if key == "escape" then
        if player.isAlive then
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
          love.graphics.setColor(255, 255, 255)
        --love.mouse.setVisible(False)
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
            love.graphics.draw(bullet.image, bullet.x, bullet.y, 0, 0.5, 0.5)
        end
        
        -- рисуем врагов из массива врагов
        for i,enemy in pairs(entity.enemies) do
            love.graphics.draw(enemy.image, enemy.x, enemy.y, enemy.rotate, enemy.scaleWidth, enemy.scaleHeight)
            if enemy.Type == 10 then
              for j,bullet in pairs(enemy.bullets) do
                love.graphics.draw(bullet.image, bullet.x, bullet.y, 0, 0.5, 0.5)
              end
            end
        end
        
        for i,bonus in pairs(entity.bonuses) do
            love.graphics.draw(bonus.image, bonus.x, bonus.y, 0, 1, 1)
        end
        
        -- отрисовка очков
        love.graphics.print("SCORE: " .. player.score, screenWidth * 0.05, screenHeight * 0.95)
        love.graphics.setColor(255, 50, 0)
        
        love.graphics.rectangle("fill", screenWidth*0.86+1, screenHeight*0.95+1, images.healthString:getWidth()/100*(player.health/10)-2,images.healthString:getHeight()-2)
        
        love.graphics.setColor(0, 50, 255)
        love.graphics.rectangle("fill",screenWidth*0.71+1,screenHeight*0.95+1,images.healthString:getWidth()/100*(player.energy/10)-2,images.healthString:getHeight()-2)
        
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(images.healthString, screenWidth * 0.86, screenHeight * 0.95, 0, 1, 1)
        love.graphics.draw(images.energyString, screenWidth * 0.71, screenHeight * 0.95, 0, 1, 1)
    else
        love.graphics.printf("Game over", 0, screenHeight / 2, screenWidth, "center")
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

function game:bossSpawn(dt)
    if world.canBossSpawn and player.score >= 5 then
        
        entity.newEnemy(10000,10)
        
        world.canBossSpawn = false
    end
end

-- создание врагов + уменьшение таймера создания врагов
function game:enemySpawn(dt)
    if world.canEnemySpawn and player.score < 5 then
        -- создаем врага 
        
        entity.newEnemy(math.random(500, 1000),math.random(1,2))
        
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

function game:bonusSpawn(dt)
    Type = math.random(1, 2)
    if world.canBonusSpawn then
        -- создаем bonus 
        local bonusImage = Type == 1 and images.healthBonus or images.energyBonus
        
        local bonusWidth = bonusImage:getWidth()
        local bonusHeight = bonusImage:getHeight()
        
        local bonus = {
            width = bonusWidth,
            height = bonusHeight,
            x = math.random(1, screenWidth - bonusWidth), -- уменьшаем границу справа, для того, чтобы корректно появлялись враги
            y = -bonusHeight, -- для того, чтобы враг появлялся из-за экрана
            speedY = math.random(25, 50),
            image = bonusImage,
            Type = Type
        }
        
        table.insert(entity.bonuses, bonus) -- записываем врага в таблицу врагов
        
        -- больше bonus нельзя создавать, до тех пор bonusySpawnTimer не станет <= 0
        world.canBonusSpawn = false
        world.bonusSpawnTimer = world.bonusSpawnInterval
    else
        world.bonusSpawnTimer = world.bonusSpawnTimer - dt
        -- отсчитываем таймер до появления нового bonus
        if world.bonusSpawnTimer <= 0 then
            world.canBonusSpawn = true -- можем создавать нового bonus
        end
    end
    
end

function game:meteorSpawn(dt)
    if world.canBonusSpawn then
        -- создаем bonus 
        local meteorImage = images.meteor
        
        local meteorWidth = bonusImage:getWidth() / 2
        local meteorHeight = bonusImage:getHeight() / 2
        
        local bonus = {
            width = bonusWidth,
            height = bonusHeight,
            x = math.random(1, screenWidth - bonusWidth), -- уменьшаем границу справа, для того, чтобы корректно появлялись враги
            y = -bonusHeight, -- для того, чтобы враг появлялся из-за экрана
            speedY = math.random(5, 100)
        }
        
        table.insert(bonuses, bonus) -- записываем врага в таблицу врагов
        
        -- больше bonus нельзя создавать, до тех пор bonusySpawnTimer не станет <= 0
        world.canBonusSpawn = false
        world.bonusSpawnTimer = world.bonusSpawnInterval
    else
        world.bonusSpawnTimer = world.bonusSpawnTimer - dt
        -- отсчитываем таймер до появления нового bonus
        if world.bonusSpawnTimer <= 0 then
            world.canBonusSpawn = true -- можем создавать нового bonus
        end
    end
end
-- передвижение врагов
function game:moveEnemies(dt)
    for i,enemy in pairs(entity.enemies) do
      entity.move(enemy, dt)
        -- если враг вышел за экран, то удаляем его из игры
        if enemy.y > screenHeight - enemy.height then
            table.remove(entity.enemies, i)
        end
    end
end

function game:moveBonuses(dt)
    for i,bonus in pairs(entity.bonuses) do
        bonus.y = bonus.y + bonus.speedY * dt
        
        -- если bonus вышел за экран, то удаляем его из игры
        if bonus.y > screenHeight - bonus.height then
            table.remove(entity.bonuses, i)
        end
    end
end

function game:moveMeteors(dt)
   for i,meteor in pairs(entity.meteors) do
        meteor.y = meteor.y + player.speedY * dt
        
        -- если bonus вышел за экран, то удаляем его из игры
        if meteor.y > screenHeight - meteor.height then
            table.remove(entity.meteors, i)
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
        player.shootTimer = player.shootTimer - dt * world.shootTimerFactor
        
        if player.shootTimer <= 0 and player.energy > 100 then
            player.canShoot = true
        end
    end
end


-- управление игроком
function game:movement(dt)
    -- управление игроком
    --[[if (math.sqrt(math.pow(love.mouse.getY() - player.y, 2) + math.pow(love.mouse.getX() - player.x, 2))) > 0 and Control == 1 then
      local x = player.x + (math.min(player.speedX * dt, (math.sqrt(math.pow(love.mouse.getY() - player.y, 2) + 
      math.pow(love.mouse.getX() - player.x, 2)))) * (love.mouse.getX() - player.x)) / 
      (math.sqrt(math.pow(love.mouse.getY() - player.y, 2) + math.pow(love.mouse.getX() - player.x, 2)))
      local y = player.y + (math.min(player.speedY * dt, (math.sqrt(math.pow(love.mouse.getY() - player.y, 2) + 
      math.pow(love.mouse.getX() - player.x, 2)))) * 
      (love.mouse.getY() - player.y)) / (math.sqrt(math.pow(love.mouse.getY() - player.y, 2) + 
      math.pow(love.mouse.getX() - player.x, 2))) 
      player.x = x
      player.y = y
    end--]]
    if Control == 1 then
      player.x, player.y = vectorMove(love.mouse.getX(), love.mouse.getY(), player.x, player.y, player.speedX, player.speedY, dt)
    end
    
    if Control == 2 then
      if love.keyboard.isDown('a', 'left') then
          player.x = player.x - player.speedX * dt
      end
      if love.keyboard.isDown('d', 'right') then
          player.x = player.x + player.speedX * dt
      end
      if love.keyboard.isDown('w', 'up') then
          player.y = player.y - player.speedY * dt
      end
      if love.keyboard.isDown('s', 'down') then
          player.y = player.y + player.speedY * dt
      end
    end
    -- стрельба (стреляем, если есть возможность)
    if love.mouse.isDown(1) and player.canShoot and Control == 1 then
        player.energy = player.energy - 20
        world.shootTimerFactor = 1
        local bullet = {
            image = images.bullet,
            x = player.x + (player.width - images.bullet:getWidth()) / 2,
            y = player.y
        }
        bullet.image = images.bullet
        -- создали пулю и запретили стрелять
        table.insert(player.bullets, bullet)
        player.canShoot = false
        player.shootTimer = world.shootInterval
        
        -- играем звук
        local sound = sounds.bullets[math.random(1, 2)]
        playSound(sound)
    end
    
    if love.mouse.isDown(2) and player.canShoot and Control == 1 then
        player.energy = player.energy - 20
        world.shootTimerFactor = 4
        local bullet = {
            image = images.bullet,
            x = player.x + (player.width - images.bullet:getWidth()) / 2,
            y = player.y
        }
        bullet.image = images.bullet2
        -- создали пулю и запретили стрелять
        table.insert(player.bullets, bullet)
        player.canShoot = false
        player.shootTimer = world.shootInterval
        
        -- играем звук
        local sound = sounds.bullets[math.random(1, 2)]
        playSound(sound)
    end
    
    if love.keyboard.isDown('space') and player.canShoot and Control == 2 then
        world.shootTimerFactor = 1
        local bullet = {
            x = player.x + (player.width - images.bullet:getWidth()) / 2,
            y = player.y
        }
        bullet.image = images.bullet
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
  for i,enemy in pairs(entity.enemies) do
    for j,bullet in pairs(player.bullets) do
      if world.shootTimerFactor == 1 then
        if checkCollision(
            enemy.x, enemy.y, enemy.width, enemy.height,
            bullet.x, bullet.y, images.bullet:getWidth(), images.bullet:getHeight()) then
              entity.enemies[i].health = entity.enemies[i].health - 750
              if entity.enemies[i].health <= 0 then 
                  table.remove(entity.enemies, i)
                  player.score = player.score + 1 -- увеличиваем счет игрока
              end
              table.remove(player.bullets, j)
                  
              local sound = sounds.enemyExplosion
              playSound(sounds.boom)
        end
      end
      if world.shootTimerFactor == 4 then
        if checkCollision(
            enemy.x, enemy.y, enemy.width, enemy.height,
            bullet.x, bullet.y, images.bullet:getWidth(), images.bullet:getHeight()) then
              entity.enemies[i].health = entity.enemies[i].health - math.random(100, 200)
              if entity.enemies[i].health <= 0 then 
                  table.remove(entity.enemies, i)
                  player.score = player.score + 1 -- увеличиваем счет игрока
              end
              table.remove(player.bullets, j)
              
                  
              local sound = sounds.enemyExplosion
              playSound(sounds.boom)
        end
      end
    end
    if enemy.Type == 10 then
      for i, bullet in pairs(enemy.bullets) do
        if checkCollision(
          bullet.x, bullet.y, bullet.width, bullet.height,
          player.x, player.y, player.width, player.height) then
          player.health = player.health- 500
          table.remove(enemy.bullets, i)
        end
      end
    end
    if checkCollision(
    enemy.x, enemy.y, enemy.width, enemy.height,
    player.x, player.y, player.width, player.height) then
    
      entity.enemies[i].health = entity.enemies[i].health - 1000
      if entity.enemies[i].health <= 0 then 
              table.remove(entity.enemies, i)
          end
      player.health = player.health - 250;
      playSound(sounds.boom)
    end
    if lowHealth(player.health) then
      player.isAlive = false
    end
  end
  for i,bonus in pairs(entity.bonuses) do
    if checkCollision(
    bonus.x, bonus.y, bonus.width, bonus.height,
    player.x, player.y, player.width, player.height) then    
      table.remove(entity.bonuses, i)
      if bonus.Type == 1 then
        if player.health > 500 then
          player.health = 1000
        end
        if player.health <= 500 then
          player.health = player.health + 500
        end
      else
      if player.energy > 500 then
          player.energy = 1000
        end
        if player.energy <= 500 then
          player.energy = player.energy + 500
        end
    end
  end
end
end

return game