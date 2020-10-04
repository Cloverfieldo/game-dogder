local bad = {}
local player = require 'player'
local totalEnemys = 0

function bad.load()
  spritesshet = love.graphics.newImage('sprite_sheet.png')
  spritesshet:setFilter( "nearest", "nearest")
  frames = {}
  local width = spritesshet:getWidth()
  local height = spritesshet:getHeight()
  --print(height, width)

  local frame_width = 18
  local frame_height = 18

  for i=0,2 do
    for j=0,2 do
      local quad = love.graphics.newQuad(j * frame_width, i * frame_height, frame_width, frame_height, width, height)
      table.insert(frames, quad)
      if #frames == 8 then
        break
      end

    end
  end

  currentFrame = 1
end
function bad.update(dt)
  currentFrame = currentFrame + 10 * dt
  if currentFrame >= 8 then
    currentFrame = 1
  end
  if totalEnemys < 20 then
    local enemy = {}
    enemy.x = love.math.random(width)
    enemy.y = 0
    enemy.tipo = love.math.random(10)
    enemy.width = 18 * 2.5
    enemy.height = 18 * 2.5
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
      --love.graphics.setColor(0, 0, 1)
    elseif v.tipo >= 2 then
      --love.graphics.setColor(1, 0, 0)
    end
    love.graphics.draw(spritesshet, frames[math.floor(currentFrame)], v.x, v.y,0, 2.5,2.5 )
  end
end
return bad