local mathUtils = require "libs.math"

return {
  update = function(dt)
    if love.keyboard.isDown("escape") then
      gamestate = "inSystem"
    end
    player:update(dt)
  end,
  draw = function()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.clear()

    local planet = galaxy.systems[localSystem].planets[localPlanet]
    local offX, offY = mathUtils.getThingOffset(player, planet.map:getDimensions(1))
    planet.map:draw(offX, offY)
    player:draw()
  end
}
