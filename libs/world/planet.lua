local assets = require "libs.assets"

return {
  new = function()
    local planet = {
      icon = assets.planets.water,
      draw = assets.draw,
      x = 200, y = 100
    }
    return planet
  end
}
