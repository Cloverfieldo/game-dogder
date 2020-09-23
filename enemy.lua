local bad = {}
local player = require 'player'
local totalEnemys = 0

function bad.update(dt)
  if totalEnemys < 20 then
    local enemy = {}
    enemy.x = love.math.random(width)
    enemy.y = 0
    enemy.tipo = love.math.random(10)
    enemy.width = 25
    enemy.height = 25
    enemy.checked = false
    enemy.speed = love.math.random(50, 200)
    table.insert(enemies, enemy)
    totalEnemys = totalEnemys + 1
    --print(totalEnemys)
  end
  
  local index = 1
  while index <= #enemies do
    enemies[index].y = enemies[index].y + enemies[index].speed * dt
    if enemies[index].y - enemies[index].height > player.y and not enemies[index].checked then
      player.score = player.score + 1
      enemies[index].checked = true
    end
    if coli.checkCollision(enemies[index], player) then
      endgame = true
    end
    if enemies[index].tipo < 2 then
      if enemies[index].x < player.x then
        enemies[index].x = enemies[index].x + enemies[index].speed  * dt
      end
      if enemies[index].x > player.x then
        enemies[index].x = enemies[index].x - enemies[index].speed  * dt
      end
    end
    if enemies[index].y >= 600 then
      table.remove(enemies, index)
      totalEnemys = totalEnemys - 1
    else
      index = index + 1
    end
  end
end
bad.draw = function()
  for i,v in ipairs(enemies) do
    --love.graphics.setColor(1, 0, 0)
    if v.tipo < 2 then
      love.graphics.setColor(0, 0, 1)
    elseif v.tipo >= 2 then
      love.graphics.setColor(1, 0, 0)
    end
    love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
  end
end
return bad