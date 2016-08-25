-- проверка пересечения двух прямоугольников
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return 
        x1 < x2+w2 and x2 < x1+w1 and
        y1 < y2+h2 and y2 < y1+h1
end

function love.load()
    
    math.randomseed(os.time())
    
    screenWidth = love.graphics.getWidth()
    screenHeigth = love.graphics.getHeight()
    
    local enemyI = 1.5
    
    world = {
        shootInterval = 0.5,
        enemyInterval = enemyI,
        enemyTimer = enemyI,
        canEnemySpawn = true
    }
    
    player = {
        x = screenWidth / 2,
        y = screenHeigth / 2,
        width = 25,
        heigth = 50,
        speedX = 100,
        speedY = 100,
        bullets = {},
        canShoot = true,
        shootTimer = shootInterval,
        score = 0,
        isAlive = true
    }
    
    enemies = {}
end

function love.update(dt)
   
    if player.isAlive then
        if world.canEnemySpawn then
            
            local enemyWidth = math.random(5, 50)
            local enemyHeight = math.random(10, 70)
            
            local enemy = {
                width = enemyWidth,
                heigth = enemyHeight,
                x = math.random(0, screenWidth - enemyWidth),
                y = -enemyHeight,
                speedX = math.random(10, 150)
            }
            
            table.insert(enemies, enemy)
            
            world.canEnemySpawn = false
            world.enemyTimer = world.enemyInterval
        
        else
            world.enemyTimer = world.enemyTimer - dt
            
            if world.enemyTimer <= 0 then
                world.canEnemySpawn = true
            end
        end
       
        for i,bullet in pairs(player.bullets) do
            bullet.y = bullet.y - bullet.speedY * dt
            
            if bullet.y < 0 then
                table.remove(player.bullets, i)
            end
        end
        
        for i,enemy in pairs(enemies) do
            enemy.y = enemy.y + dt * enemy.speedX
            
            if enemy.y > screenHeigth then
                table.remove(enemies, i)
            end
        end
        
        if not player.canShoot then
            player.shootInterval = player.shootInterval - dt
            
            if player.shootInterval <= 0 then
                player.canShoot = true
            end
        end
        
        --
        if love.keyboard.isDown('escape') then
            love.event.push('quit')
        end
        
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
        
        if player.x < 0 then
            player.x = 0
        elseif player.x > screenWidth - player.width then
            player.x = screenWidth - player.width
        end
        
        if player.y < 0 then
            player.y = 0
        elseif player.y > screenHeigth - player.heigth then
            player.y = screenHeigth - player.heigth
        end
        
        if love.keyboard.isDown('space') and player.canShoot then
            local bullet = {
                x = player.x + player.width / 2,
                y = player.y,
                width = 3,
                heigth = 5,
                speedY = 50
            }
            
            table.insert(player.bullets, bullet)
            
            player.canShoot = false
            player.shootInterval = world.shootInterval
        end
        
        for i,enemy in pairs(enemies) do
            for j,bullet in pairs(player.bullets) do
                if checkCollision(
                    enemy.x, enemy.y, enemy.width, enemy.heigth,
                    bullet.x, bullet.y, bullet.width, bullet.heigth
                ) then
                    table.remove(enemies, i)
                    table.remove(player.bullets, j)
                    
                    player.score = player.score + 1
                end
            end
            
            if checkCollision(
                enemy.x, enemy.y, enemy.width, enemy.heigth,
                player.x, player.y, player.width, player.heigth
            ) then
                player.isAlive = false
            end
        end
    end
end

function love.draw()
    if player.isAlive then
        love.graphics.rectangle("fill", player.x, player.y, player.width, player.heigth)
        
        for i,bullet in pairs(player.bullets) do
            love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.heigth)
        end
        
        for i,enemy in pairs(enemies) do
            love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.heigth)
        end
        
        love.graphics.print("SCORE: " .. tostring(player.score), screenWidth * 0.05, screenHeigth * 0.95)
    else
        love.graphics.print("Game over", screenWidth / 2, screenHeigth / 2)
    end
end