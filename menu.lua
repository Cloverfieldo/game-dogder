local menu = {}
function menu.newButton(text,fn)
  return {
    text = text,
    fn = fn,
    now = false,
    last = false
  }
end
local buttons = {}
local font = love.graphics.newFont(32)
menu.load = function(self)
  table.insert(buttons, self.newButton(
      "Start Game",
      function()  state = 'gameplay' end
    ))

  table.insert(buttons, self.newButton(
      "Exit",
      function() love.event.quit() end
    ))
end

menu.draw = function()
  
  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight()

  local button_width = ww * (1/3)
  local button_height = 64
  local margin = 16


  local total_height = (button_height + margin) * #buttons
  local cursor_y = 0

  for i,v in ipairs(buttons) do
    v.last = v.now

    local color = {0.5, 0.3, 0.5}
    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y
    local mx, my = love.mouse.getPosition()
    local hot = mx > bx and mx < bx + button_width and
                my > by and my < by + button_height
    if hot then
      --print('ok')
      color = {0.5,0.3,0.5, 0.5}
    end
    v.now = love.mouse.isDown(1)
    if v.now and not v.last and hot then
      
      v.fn()
    end
    love.graphics.setColor(unpack(color))
    love.graphics.rectangle(
      'fill',
      bx,
      by,
      button_width,
      button_height

    )
    love.graphics.setColor(0,0,0)
    love.graphics.print(
      v.text,
      font,
      bx,
      by

    )

    cursor_y = cursor_y + (button_height + margin)
  end
end
return menu