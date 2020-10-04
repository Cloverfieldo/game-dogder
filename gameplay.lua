local gameplay = {}
cool_enemy = require 'enemy'
player = require 'player'
coli = require 'collision'
endgame = false
enemies = {}
--test
width = love.graphics.getWidth()
height = love.graphics.getHeight()
function gameplay.load()
  --if not endgame and state == 'gameplay' then
  cool_enemy.load()
end
function gameplay.update(dt)
  if not endgame and state == 'gameplay' then
    player.update(dt)
    --cool_enemy.sprite_work(dt)
    cool_enemy.update(dt)
  end
end

function gameplay.draw()

  fi = love.graphics.newFont(12)
  love.graphics.setFont(fi)
  love.graphics.print(tostring(love.timer.getFPS()), 500, 0)
  love.graphics.print(tostring(player.score), 0, 30)
  player.draw()
  cool_enemy.draw()
  if endgame then
    fo = love.graphics.newFont(50)
    love.graphics.setFont(fo)
    love.graphics.print('LOST TRY AGAIN', 250, 300)
  end
end

function gameplay.keyreleased(k)
  if k == 'f5' then
    love.event.quit('restart')

  end
end
return gameplay