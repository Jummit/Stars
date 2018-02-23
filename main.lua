function love.load()
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"

  galaxy = galaxy.new()
  gamestate = "galaxyMap"
end

function love.update(dt)
  gamestates.update(gamestate, dt)
end

function love.draw()
  gamestates.draw(gamestate)
end
