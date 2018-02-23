local assets = require "libs.assets"
local systemWidth, systemHeight = 1000, 1000

return {
  new = function()
    local planet = {
      icon = assets.world.planet.water,
      draw = assets.draw,
      x = math.random(-systemWidth/2, systemWidth/2), y = math.random(-systemHeight/2, systemHeight/2)
    }
    return planet
  end
}
