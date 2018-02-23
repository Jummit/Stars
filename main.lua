function love.load()
  galaxy = require "libs.world.galaxy"
  gamestates = require "libs.gamestates"
  galaxy = galaxy.new()
  gamestate = "galaxyMap"
end

function love.update(dt)
  gamestates[gamestate].update(dt)
end

function love.draw()
  gamestates[gamestate].draw()
end
