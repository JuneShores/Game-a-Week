debug = true

local conf = require('conf')

function love.load()
  state = 0
  honey = {}
  carla = {}
  center = {}
  center.y = conf.t.window.height / 2
  center.x = conf.t.window.width / 2
end

function reset(key)
  function love.keypressed(key)
    if key == "x" then
      state = 0
    end
  end
end

function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
  x2 < x1+w1 and
  y1 < y2+h2 and
  y2 < y1+h1
end

function love.update(dt)
  function love.keypressed(key)
    if state == 0 then
      if key == "x" then
        state = 1
        honey.x = 90
        honey.y = 90
        honey.width = 100
        honey.height = 200
        honey.speed = 100
        honey.lipsy = honey.y + 75
        honey.lipsx = honey.x + 125
        honey.img = love.graphics.newImage("assets/honey.png")
        carla.img = love.graphics.newImage("assets/carla.png")
        carla.x = 200
        carla.y = 400
        carla.width = 100
        carla.height = 200
        carla.lipsy = carla.y
        carla.lipsx = carla.x + 125
        carla.foreheady = carla.y
        carla.foreheadx = carla.x
        carla.necky = carla.y
        carla.neckx = carla.x + 150
      end
    end
  end
  if state == 1 then
    honey.lipsy = honey.y + 75
    honey.lipsx = honey.x + 125
    if love.keyboard.isDown("up") then
      honey.x = honey.x - (honey.speed * dt)
    end
    if love.keyboard.isDown("down") then
      honey.x = honey.x + (honey.speed * dt)
    end
    if love.keyboard.isDown("right") then
      honey.y = honey.y + (honey.speed * dt)
    end
    if love.keyboard.isDown("left") then
      honey.y = honey.y - (honey.speed * dt)
    end

    honey.y = honey.y + love.math.random(1, 20)
    honey.x = honey.x + love.math.random(1, 20)
    honey.y = honey.y - love.math.random(1, 20)
    honey.x = honey.x - love.math.random(1, 20)

    x1,y1,w1,h1 = honey.lipsx,honey.lipsy,25,25

    x2,y2,w2,h2 = carla.lipsx,carla.lipsy,25,25

    if CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2) then
      state = 3
    end

    x2,y2,w2,h2 = carla.foreheadx,carla.foreheady,50,50

    if CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2) then
      state = 5
    end

    x2,y2,w2,h2 = carla.neckx,carla.necky,50,50

    if CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2) then
      state = 4
    end
  end
  if state == 3 then
    reset(key)
  end
  if state == 4 then
    reset(key)
  end
  if state == 5 then
    reset(key)
  end
end


function love.draw()
  if state == 0 then
    love.graphics.printf('PRESS\nX\nTO START', center.x, center.y, 100, "center")
  end
  if state == 1 then
    -- PLAY GAME
    love.graphics.setColor(210, 158, 56)
    love.graphics.draw(honey.img, honey.y, honey.x)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(carla.img, 400, 200)
    love.graphics.setColor(255, 255, 255)
  end

  if state == 3 then
    -- LIPS
    love.graphics.printf("AW YISS!", center.x, center.y, 145, "center")
  end
  if state == 4 then
    -- NECK
    love.graphics.printf("what just happened", center.x, center.y, 145, "center")
  end
  if state == 5 then
    -- FOREHEAD
    love.graphics.printf("D'awww.", center.x, center.y, 145, "center")
  end
end
