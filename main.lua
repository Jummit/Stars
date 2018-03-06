function love.load()
  math.randomseed(os.time())
  w, h = love.graphics.getDimensions()
  assets = require "libs.assets"
  tilemap = require "libs.tilemap"
  quest = require "libs.quest"
  items = require "libs.items"
  planet = require "libs.world.planet"
  galaxy = require "libs.world.galaxy"
  system = require "libs.world.system"
  gamestates = require "libs.gamestates"
  spaceship = require "libs.spaceship"
  player = require "libs.player"
  mathUtils = require "libs.math"
  npcs = require "libs.npcs"
  fw = require "libs.fw"

  galaxy = galaxy.new()
  localSystem = 1
  localPlanet = 1
  gamestate = "inventory"
  lastSwitch = 1
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
