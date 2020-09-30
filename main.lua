local gameplay = require 'gameplay'
local menu = require 'menu'
state = 'menu'
function love.load()
  menu:load()
end
function love.update(dt)
  if state == 'menu' then

  end
  gameplay.update(dt)
end
function love.draw()
  if state == 'menu' then
    menu:draw()
  elseif state == 'gameplay' then
    gameplay.draw()
  end
end
function love.keyreleased(k)
  gameplay.keyreleased(k)
end
