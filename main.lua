function love.load()
  math.randomseed(os.time())
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"

  spaceship = require "libs.spaceship"
  player = require "libs.player"
  assets = require "libs.assets"
  galaxy = galaxy.new()
  localSystem = 1
  localPlanet = 1
  gamestate = "inventory"
  lastSwitch = 1
  w, h = love.graphics.getDimensions()
  function changeState(state)
    if lastSwitch > 0.2 then
      gamestate = state
      lastSwitch = 0
    end
  end
  love.window.setMode(love.window.getDesktopDimensions())
  love.window.setTitle("Stars - a space exploration game")
  love.window.setIcon(assets.tiles.planet.wall.image:getData())
end

function love.update(dt)
  lastSwitch = lastSwitch+dt
  gamestates.update(gamestate, dt)
  for questNum = 1, #spaceship.quests do
    local quest = spaceship.quests[questNum]
    if quest:update() then
      quest.finishedFunc()
      table.remove(spaceship.quests, questNum)
    end
  end
end

function love.draw()
  gamestates.draw(gamestate)
end
