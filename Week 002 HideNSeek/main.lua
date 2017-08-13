-- Main loop for Hide & Seek

local conf = require('conf')

function love.load()
  screen = "start"
  -- Define middle of screen.
  center = {}
  center.height = {}
  center.height.base = conf.t.window.height / 2
  center.width = {}
  center.width.base = conf.t.window.width / 2
  center.width.startmessage = center.width.base - 50
end

function reset(key)
  function love.mousereleased(x,y,button,istouch)
    if button == 1 then
      screen = "start"
    end
  end
end

local function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
  x2 < x1+w1 and
  y1 < y2+h2 and
  y2 < y1+h1
end

function love.update(dt)
  function love.mousereleased(x, y, button)
    if screen == "start" then
      if button == 1 then
        screen = "play"
        player = {}
        player.position = {}
        player.position.x = love.mouse.getX()
        player.position.y = love.mouse.getY()
        hider = {}
        hider.position = {}
        hider.maxPosX = conf.t.window.width - 110
        hider.maxPosY = conf.t.window.height - 110
        hider.position.x = love.math.random(1, hider.maxPosX)
        hider.position.y = love.math.random(1, hider.maxPosY)
      end
    end
    if screen == "win" then
      if button == 1 then
        screen = "start"
      end
    end
  end
  if screen == "play" then
    player.position.x = love.mouse.getX() - 75
    player.position.y = love.mouse.getY() - 75
    x1 = love.mouse.getX() + 25
    y1 = love.mouse.getY() + 25
    w1 = 50
    h1 = 50
    x2 = hider.position.x
    y2 = hider.position.y
    w2 = 100
    h2 = 100

    if CheckCollision(x1,y1,h1,w1,x2,y2,h2,w2) then
      screen = "win"
    end
  end
end

local function flashlight()
  love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 150)
end

function love.draw()
  if screen == "start" then
    love.graphics.printf("PRESS LEFT MOUSE BUTTON TO START", center.width.startmessage, center.height.base, 100, "center")
  end
  if screen == "play" then
    love.graphics.stencil(flashlight, "replace", 1)

    love.graphics.setStencilTest("equal", 1)
    love.graphics.rectangle("fill", hider.position.x, hider.position.y, 100, 100)
    love.graphics.setStencilTest()
  end
  if screen == "win" then
    love.graphics.printf("You win!", center.width.startmessage, center.height.base, 100, "center")
  end
end
