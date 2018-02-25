function love.load()
  math.randomseed(os.time())
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"

  spaceship = require "libs.spaceship"
  player = require "libs.player"
  galaxy = galaxy.new()
  localSystem = 1
  localPlanet = 1
  gamestate = "onPlanet"
end

function love.update(dt)
  gamestates.update(gamestate, dt)
end

function love.draw()
  gamestates.draw(gamestate)
end
