local assets = require "libs.assets"
local planet = require "libs.world.planet"

return {
  new = function()
    local system = {
      icon = assets.world.system,
      planets = {},
      x = math.random(1, 500), y = math.random(1, 300),
      draw = assets.draw
    }
    return system
  end
}
