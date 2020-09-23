cool_enemy = require 'enemy'
player = require 'player'
coli = require 'collision'
endgame = false
enemies = {}
width = love.graphics.getWidth()
height = love.graphics.getHeight()
function love.update(dt)
  if not endgame then
    player.update(dt)
    cool_enemy.update(dt)
  end
end

function love.draw()
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

function love.keyreleased(k)
  if k == 'f5' then
    love.event.quit('restart')
  end
end