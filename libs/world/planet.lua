local assets = require "libs.assets"

return {
  new = function()
    local planet = {
      icon = assets.world.planet.water,
      draw = assets.draw,
      x = math.random(1, 600), y = math.random(1, 300)
    }
    return planet
  end
}
