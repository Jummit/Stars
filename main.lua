function love.load()
  galaxy = require "libs.world.galaxy"
  galaxy = galaxy.new()
end

function love.update(dt)
end

function love.draw()
  galaxy:draw()
end
