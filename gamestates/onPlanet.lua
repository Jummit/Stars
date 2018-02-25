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

    local offX, offY = mathUtils.getThingOffset(player)
    galaxy.systems[localSystem].planets[localPlanet].map:draw(offX, offY)
    player:draw()
  end
}
