function love.load()
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"

  galaxy = galaxy.new()
  localSystem = 1
  localPlanet = 1
  gamestate = "inSystem"
end

function love.update(dt)
  gamestates.update(gamestate, dt)
end

function love.draw()
  gamestates.draw(gamestate)
end
