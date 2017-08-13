-- Main loop for Stoked

local conf = require('conf')

function love.load()
  screen = "start"
  power = 0
  -- Define middle of screen.
  center = {}
  center.height = {}
  center.height.base = conf.t.window.height / 2
  center.width = {}
  center.width.base = conf.t.window.width / 2
  center.width.startmessage = center.width.base - 50
end

function reset()
  function love.mousereleased(x,y,button)
    if button == 1 then
      screen = "start"
    end
  end
end

function love.update(dt)
  function love.mousereleased(x,y,button)
    if screen == "start" and button == 1 then
      screen = "play"
      power = 150
    end
    if screen == "lose" and button == 1 then
      screen = "start"
    end
    local mx = love.mouse.getX()
    local my = love.mouse.getY()
    local x = 250
    local y = 200
    if screen == "play" and button == 1 then
      if power < 250 then
        if mx >= x and mx <= x + 300 then
          if my >= y and my <= y + 100 then
            power = power + 10
          end
        end
      end
    end
  end
  if screen == "play" and power > 0 then
    power = power - 0.25
  end
  if power == 0 and screen == "play" then
    screen = "lose"
  end
  if power >= 250 and screen == "play" then
    screen = "lose"
  end
  if screen == "play" then
    if power <= 25 then
      r, g, b, a = 255, 40, 40, 255
    end
    if power >= 26 and power <= 50 then
      r, g, b, a = 255, 250, 40, 255
    end
    if power >= 51 and power <= 150 then
      r, g, b, a = 40, 255, 40, 255
    end
    if power >= 151 and power <= 200 then
      r, g, b, a = 255, 255, 40, 255
    end
    if power >= 201 and power <= 250 then
      r, g, b, a = 255, 40, 40, 255
    end
  end
end

function love.draw()
  if screen == "start" then
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf("PRESS LEFT MOUSE BUTTON TO START", center.width.startmessage, center.height.base, 100, "center")
  end
  if screen == "play" then
    love.graphics.setColor(255,50,50,255)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", 250,200,300,100)
    love.graphics.setColor(255,255,255,255)
    powermessage = "Power is " .. power
    love.graphics.printf(powermessage, center.width.startmessage, 380, 100, "left")
    -- draw state square
    love.graphics.setColor(r, g, b, a)
    love.graphics.rectangle("fill", center.width.startmessage, 100, 100, 100)
  end
  if screen == "lose" then
    love.graphics.printf("GAME OVER\nClick to continue", center.width.startmessage, center.height.base, 100, "center")
  end
end
