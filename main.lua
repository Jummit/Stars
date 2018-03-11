function love.load()
  math.randomseed(os.time())
  love.window.setMode(love.window.getDesktopDimensions())
  love.window.setTitle("Stars - a space exploration game")
  w, h = love.graphics.getDimensions()
  localSystem = 1
  localPlanet = 1
  gamestate = "onGround"
  lastSwitch = 1
  assets = require "libs.assets"
  tilemap = require "libs.tilemap"
  items = require "libs.items"
  quest = require "libs.quest"
  npcs = require "libs.npcs"
  planet = require "libs.world.planet"
  system = require "libs.world.system"
  galaxy = require "libs.world.galaxy"
  galaxy = galaxy.new()
  spaceship = require "libs.spaceship"
  location = galaxy.systems[localSystem].planets[localPlanet]
  gamestates = require "libs.gamestates"
  player = require "libs.player"
  mathUtils = require "libs.math"
  fw = require "libs.fw"

  function changeState(state)
    if lastSwitch > 0.2 then
      gamestate = state
      lastSwitch = 0
    end
  end
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
