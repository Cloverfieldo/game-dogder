endgame = false
player = {}
player.x = 300
player.y = 500
player.speed = 500
player.width = 50
player.height = 50
player.score = 0
enemies = {}
width = love.graphics.getWidth()
print(width)
function checkCollision(a, b)
  --With locals it's common usage to use underscores instead of camelCasing
  local a_left = a.x
  local a_right = a.x + a.width
  local a_top = a.y
  local a_bottom = a.y + a.height

  local b_left = b.x
  local b_right = b.x + b.width
  local b_top = b.y
  local b_bottom = b.y + b.height

  --If Red's right side is further to the right than Blue's left side.
  if a_right > b_left and
  --and Red's left side is further to the left than Blue's right side.
  a_left < b_right and
  --and Red's bottom side is further to the bottom than Blue's top side.
  a_bottom > b_top and
  --and Red's top side is further to the top than Blue's bottom side then..
  a_top < b_bottom then
    --There is collision!
    return true
  else
    --If one of these statements is false, return false.
    return false
  end
end
local totalEnemys = 0
function love.update(dt)
  if not endgame then
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
    --local totalEnemys = 0
    if totalEnemys < 20 then
      enemy = {}
      enemy.x =  love.math.random(800)
      enemy.y = 0
      enemy.width = 30
      enemy.height = 30
      enemy.checked = false
      enemy.speed = love.math.random(50,250)
      table.insert(enemies, enemy)
      totalEnemys = totalEnemys + 1
    end
    for i,v in ipairs(enemies) do
      v.y = v.y + v.speed * dt
      if v.y - v.height > player.y and not v.checked then
        player.score = player.score + 1
        v.checked = true
      end
      if checkCollision(v, player) then
        endgame = true
      end
    end
    local index = 1
    while index <= #enemies do
      if enemies[index].y > 600 then
        table.remove(enemies, index)
        totalEnemys = totalEnemys - 1
      else
        index = index + 1
      end
    end
  end
end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('fill', player.x, player.y, player.height, player.width)
  love.graphics.print(tostring(player.score), 0, 30)
  for i,v in ipairs(enemies) do
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
  end
  if endgame then
    fo = love.graphics.newFont(50)
    love.graphics.setFont(fo)
    love.graphics.print('LOST TRY AGAIN', 300, 300)
  end
end

function love.keyreleased(k)
  if k == 'f5' then
    love.event.quit('restart')
  end
end