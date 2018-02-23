local assets = require "libs.assets"
local systemWidth, systemHeight = 1000, 1000
local w, h = love.graphics.getDimensions()

return {
  new = function()
    local planet = {
      icon = assets.world.planet.water,
      draw = function(self)
        local offX, offY = spaceship:getPlanetOff()
        self.icon:draw(
          self.x+offX,
          self.y+offY
        )
      end,
      x = math.random(-systemWidth/2, systemWidth/2), y = math.random(-systemHeight/2, systemHeight/2)
    }
    return planet
  end
}
