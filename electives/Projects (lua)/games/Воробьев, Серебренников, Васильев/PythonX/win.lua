win = {}

function win:draw()
  love.graphics.printf("You win!", 0, screenHeight/2, screenWidth, "center")
end

function win:keypressed(key)
  if key == "escape" then
    gamestate.switch(menu)
  end
end

return win