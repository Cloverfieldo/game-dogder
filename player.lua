player = {}
player.x = 300
player.y = 500
player.speed = 500
player.width = 50
player.height = 50
player.score = 0
player.update = function(dt)
  if love.keyboard.isDown('d') and player.x < 800 - player.width then
    print(player.x)
    player.x = player.x + player.speed * dt
  elseif love.keyboard.isDown('a') and player.x > 0 then
    player.x = player.x - player.speed * dt
  end
  if love.keyboard.isDown('s') then
    player.y = player.y + player.speed * dt
  elseif love.keyboard.isDown('w') then
    player.y = player.y - player.speed * dt
  end
end
function player.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('fill', player.x, player.y, player.height, player.width)
end
return player